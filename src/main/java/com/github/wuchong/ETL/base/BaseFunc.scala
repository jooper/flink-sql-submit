package com.github.wuchong.ETL.base

import org.apache.flink.api.scala.ExecutionEnvironment
import org.apache.flink.streaming.api.scala.StreamExecutionEnvironment

class BaseFunc {
  def initEvr(t: Int): Any = {
    t match {
      case 1 => ExecutionEnvironment.getExecutionEnvironment
      case 2 => StreamExecutionEnvironment.getExecutionEnvironment
    }
  }

}
