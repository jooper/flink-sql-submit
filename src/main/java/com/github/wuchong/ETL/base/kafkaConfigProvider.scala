package com.github.wuchong.ETL.base

import java.util.Properties

object kafkaConfigProvider {

  case class KafkaConfig() {
    val properties = new Properties()
    val kafkaServer = "10.158.5.80:9092,10.158.5.83:9092,10.158.5.81:9092"
    val topicGroupId = "com.flinklearn.main.Main"

    properties.setProperty("bootstrap.servers", kafkaServer)
    properties.setProperty("group.id", topicGroupId)
  }

  def getCnf(): Properties = {
    new KafkaConfig().properties
  }

}
