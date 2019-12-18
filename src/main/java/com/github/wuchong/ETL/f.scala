package com.github.wuchong.ETL

import java.util.Properties

import com.alibaba.fastjson.{JSON, JSONObject}
import org.apache.flink.api.common.serialization.SimpleStringSchema
import org.apache.flink.streaming.api.scala.{DataStream, StreamExecutionEnvironment, _}
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaConsumer
import org.apache.flink.table.api.Table
import org.apache.flink.table.api.scala.StreamTableEnvironment

object f {
  def main(args: Array[String]): Unit = {
    new f().startApp()
  }
}


class f {
  def startApp(): Unit = {
    val properties = new Properties()
    properties.setProperty("bootstrap.servers", "10.158.5.80:9092,10.158.5.83:9092,10.158.5.81:9092")
    properties.setProperty("group.id", "com.flinklearn.main.Main")
    val env = StreamExecutionEnvironment.getExecutionEnvironment
    //    val settings: EnvironmentSettings = EnvironmentSettings.newInstance.useBlinkPlanner.inBatchMode().build

    //从kafka读取数据，得到stream
    val stream: DataStream[String] = env
      .addSource(new FlinkKafkaConsumer[String]("test_ogg", new SimpleStringSchema(), properties))
      .map(line => {
        var rtn: String = null
        try {
          val temp: JSONObject = JSON.parseObject(line).getJSONObject("after")
          rtn=temp.toString();
        } catch {
          case ex: Exception => {
            ex.printStackTrace()
          }
        }
        rtn
      }).filter(line => line != null)


    val streamTableEnv: StreamTableEnvironment = StreamTableEnvironment.create(env)
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

