package com.github.wuchong.ETL

import java.util.Properties

import com.alibaba.fastjson.{JSON, JSONObject}
import com.github.wuchong.ETL.base.kafkaConfigProvider
import com.github.wuchong.ETL.utilites.fastJsonExt
import org.apache.flink.api.common.serialization.SimpleStringSchema
import org.apache.flink.streaming.api.scala.{DataStream, StreamExecutionEnvironment, _}
import org.apache.flink.streaming.connectors.kafka.{FlinkKafkaConsumer, FlinkKafkaProducer}
import org.apache.flink.table.api.Table
import org.apache.flink.table.api.scala.StreamTableEnvironment

/**
  * date：2019-12-18
  * funcation：清理通过ogg同步到kafka中的数据，只保留after之后的数据到kafka中
  * $FLINK_DIR/bin/flink run -d -p 4 -c com.github.wuchong.ETL.ETL_OGG_DATA_SINKTO_KAFKA  target/flink-sql-submit.jar "sourceTopicId" "sinkTopicId" "jobname"
  * author：
  */


object ETL_OGG_DATA_SINKTO_KAFKA {
  var sourceTopicId = "test_ogg"
  var sinkTopicId = "user_behavior"
  var jobName = "elt_ogg_data_sinkto_kafka"

  def main(args: Array[String]): Unit = {
    if (args.length > 0) {
      sourceTopicId = String.valueOf(args(0))
      sinkTopicId = String.valueOf(args(1))
      jobName = String.valueOf(args(2))
      new ETL_OGG_DATA_SINKTO_KAFKA().startEtlApp(sourceTopicId, sinkTopicId, jobName)
    }
    else {
      throw new RuntimeException("sink topicid and jobname mast providered")
    }
  }
}


class ETL_OGG_DATA_SINKTO_KAFKA {

  def startEtlApp(sourceTopicId: String, sinkTopicId: String, jobName: String): Unit = {

    val (env: StreamExecutionEnvironment, streamTableEnv: StreamTableEnvironment, properties: Properties) = getEnv

    val etlResult: DataStream[String] = getSourceOggDataFromKafka(sourceTopicId, env, streamTableEnv, properties)

    sinkDataToKafka(sinkTopicId, etlResult, properties)

    env.execute(jobName)
  }

  private def getEnv = {
    val env = StreamExecutionEnvironment.getExecutionEnvironment
    val streamTableEnv: StreamTableEnvironment = StreamTableEnvironment.create(env)
    val properties = kafkaConfigProvider.getCnf()
    (env, streamTableEnv, properties)
  }

  //获取kafka中原始的ogg数据，并取得after之后的数据
  private def getSourceOggDataFromKafka(sourceTopicId: String, env: StreamExecutionEnvironment, streamTableEnv: StreamTableEnvironment,
                                        properties: Properties) = {
    //从kafka读取数据，得到stream
    val stream: DataStream[String] = env
      .addSource(new FlinkKafkaConsumer[String](sourceTopicId, new SimpleStringSchema(), properties))
      .map(line => {
        var rtn: String = null
        try {
          val logData: JSONObject = JSON.parseObject(line)
          val afterData: JSONObject = logData.getJSONObject("after")
          val operationType = logData.getString("op_type")
          val tableName = logData.getString("table") //所有消息写到一个topic中时，可以通过table来取不同的值
          afterData.put("table", tableName)
          afterData.put("OP_TYPE", operationType) //加入操作类型：U I D
          rtn = fastJsonExt.transToLowerObject(afterData.toString()).toString; //将所有的key转换为小写
        } catch {
          case ex: Exception => {
            ex.printStackTrace()
          }
        }
        rtn
      }).filter(line => line != null)

    //    val tableEnv: TableEnvironment = TableEnvironment.create(settings)
    //将stream注册为temp_alert表，并打印msg字段
    //    val table: Table = stream.toTable(streamTableEnv)
    streamTableEnv.registerDataStream("ogg", stream)
    val table: Table = streamTableEnv.sqlQuery("select * from ogg")

    val value: DataStream[String] = streamTableEnv.toAppendStream[String](table)
    value.print()
    value
  }

  //将数据存储到kafka中指定的的topicid中
  private def sinkDataToKafka(sinkTopicId: String, stream: DataStream[String], properties: Properties): Unit = {
    val producer = new FlinkKafkaProducer[String](sinkTopicId, new SimpleStringSchema(), properties)
    stream.addSink(producer).name(sinkTopicId)
      .setParallelism(5)
  }

}

