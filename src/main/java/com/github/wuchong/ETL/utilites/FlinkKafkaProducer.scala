//package com.github.wuchong.ETL.utilites
//
//import java.util.Properties
//
//import com.github.wuchong.ETL.base.{BaseFunc, SerializeDesSerializeProvider}
//import org.apache.flink.streaming.api.TimeCharacteristic
//import org.apache.flink.streaming.api.functions.source.SourceFunction
//import org.apache.flink.streaming.api.scala.{DataStream, StreamExecutionEnvironment}
//import org.apache.flink.streaming.connectors.kafka.{FlinkKafkaConsumer, FlinkKafkaProducer}
//import org.apache.flink.streaming.util.serialization.SimpleStringSchema
//
//object FlinkKafkaProducer extends BaseFunc {
//  private val ZOOKEEPER_HOST = "master:2181,slave3:2181,slave2:2181"
//  private val KAFKA_BROKER = "master:9092,slave3:9092,slave2:9092"
//  private val TRANSACTION_GROUP = "com.jwp.flink"
//  private val TOPIC_NAME = "tt"
//
//  def main(args: Array[String]): Unit = {
//    produceMessage
//  }
//
//
//  def builderKafkaProducerStr(): FlinkKafkaProducer[String] = {
//    val pros: Properties = getKafkaProperties
//    val producer: FlinkKafkaProducer[String] = new FlinkKafkaProducer(TOPIC_NAME, new SimpleStringSchema(), pros);
//    producer
//  }
//
//  //TypedKeyedDeserializationSchema
//  def buildKafkaConsumer(): FlinkKafkaConsumer[String] = {
//    val pros = getKafkaProperties
//    val consumer: FlinkKafkaConsumer[String] = new FlinkKafkaConsumer(TOPIC_NAME, new SimpleStringSchema(), pros)
//    //从最早开始消费
//    //    consumer.setStartFromEarliest
//    consumer.setStartFromTimestamp(1573714229769l)
//    consumer
//  }
//
//  private def produceMessage = {
//    val env = initEvr(2).asInstanceOf[StreamExecutionEnvironment]
//    env.setStreamTimeCharacteristic(TimeCharacteristic.EventTime)
//    val data: DataStream[String] = env.addSource(new CustomNonParalleSourceFunction2()).setParallelism(1)
//    val producer: FlinkKafkaProducer[String] = builderKafkaProducerStr()
//    data.addSink(producer)
//    env.execute("kafka topic")
//  }
//
//
//  private def getKafkaProperties = {
//    val pros = new Properties()
//    pros.setProperty("bootstrap.servers", KAFKA_BROKER)
//    pros.setProperty("zookeeper.connect", ZOOKEEPER_HOST)
//    pros.setProperty("group.id", TRANSACTION_GROUP)
//    pros.put("enable.auto.commit", "true")
//    pros.put("auto.commit.interval.ms", "10000")
//    pros
//  }
//
//
//}
//
//
//class CustomNonParalleSourceFunction2 extends SourceFunction[String] {
//
//  var count = 1L
//  var isRunning = true
//
//  override def run(sourceContext: SourceFunction.SourceContext[String]): Unit = {
//    while (isRunning) {
//      val strings = "flink kafka"
//
//      val dataJson: model = model("joo", "man", 10, "cd")
//      val map = SerializeDesSerializeProvider.ToJsonStr(dataJson)
//      println(s"obj to json:$map")
//
//
//      sourceContext.collect(map)
//      Thread.sleep(1000)
//    }
//  }
//
//  override def cancel(): Unit = {
//    isRunning = false
//  }
//}
//
//
//case class model(name: String, sex: String, age: Int, addr: String)
//
//
//
//
//
//
