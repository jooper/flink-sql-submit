package com.github.wuchong.ETL

import java.util.Properties

import com.alibaba.fastjson.{JSON, JSONObject}
import org.apache.flink.api.common.serialization.SimpleStringSchema
import org.apache.flink.streaming.api.scala.{DataStream, StreamExecutionEnvironment, _}
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaConsumer
import org.apache.flink.table.api.Table
import org.apache.flink.table.api.scala.StreamTableEnvironment

/**
  * date：2019-12-18
  * funcation：清理通过ogg同步到kafka中的数据，只保留after之后的数据到kafka中
  * author：
  */

case class KafkaConfig() {
  val properties = new Properties()
  val kafkaServer = "10.158.5.80:9092,10.158.5.83:9092,10.158.5.81:9092"
  val topicGroupId = "com.flinklearn.main.Main"

  properties.setProperty("bootstrap.servers", kafkaServer)
  properties.setProperty("group.id", topicGroupId)
}


object ETL_OGG_DATA {
  def main(args: Array[String]): Unit = {
    new ETL_OGG_DATA().startApp()
  }
}


class ETL_OGG_DATA {
  def startApp(): Unit = {

    val env = StreamExecutionEnvironment.getExecutionEnvironment
    val streamTableEnv: StreamTableEnvironment = StreamTableEnvironment.create(env)

    val properties = new KafkaConfig().properties

    //从kafka读取数据，得到stream
    val stream: DataStream[String] = env
      .addSource(new FlinkKafkaConsumer[String]("test_ogg", new SimpleStringSchema(), properties))
      .map(line => {
        var rtn: String = null
        try {
          val logData: JSONObject = JSON.parseObject(line)
          val afterData: JSONObject = logData.getJSONObject("after")
          val operationType = logData.getString("op_type")
          afterData.put("op_type", operationType)
          rtn = afterData.toString();
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

    env.execute("Kafka sql test.")
  }
}

