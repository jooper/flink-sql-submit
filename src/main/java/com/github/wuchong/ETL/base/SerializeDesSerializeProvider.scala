package com.github.wuchong.ETL.base

import java.io.{ByteArrayInputStream, ByteArrayOutputStream, ObjectInputStream, ObjectOutputStream}

import com.google.gson.Gson

import scala.util.parsing.json.JSON


class SerializeDesSerializeProvider {

}


object SerializeDesSerializeProvider {
  //序列化（将对象传入，变成字节流）  流式数据
  def serialize[T](o: T): Array[Byte] = {
    val bos = new ByteArrayOutputStream() //内存输出流，和磁盘输出流从操作上讲是一样的
    val oos = new ObjectOutputStream(bos)
    oos.writeObject(o)
    oos.close()
    bos.toByteArray
  }

  //反序列化   流式数据
  def deserialize[T](bytes: Array[Byte]): T = {
    val bis = new ByteArrayInputStream(bytes)
    val ois = new ObjectInputStream(bis)
    ois.readObject.asInstanceOf[T] //进行类型转换，因为你要返回这个类型
  }


  //处理map->json
  def mapToJson(map: scala.collection.mutable.Map[String, String]): String = {
    scala.util.parsing.json.JSONObject(scala.collection.immutable.Map(map.toList: _*)).toString()
  }


  //  Gson
  //  obj  to json str
  def ToJsonStr[T](objStr: T): String = {
    val gson = new Gson
    //    gson.toJson(objStr, classOf[T])
    gson.toJson(objStr)
  }


  //GSON
  //json str to obj
  def ToObject[T](jsonStr: String): String = {
    //    val gson = new Gson
    //    gson.fromJson(jsonStr, classOf[T])
    ""
  }

  //gson
  //判断字符串是否有效json格式
  def isGoodJson(json: String): Boolean = {

    if (null == json) {
      return false
    }
    val result = JSON.parseFull(json) match {
      case Some(_: Map[String, Any]) => true
      case None => false
      case _ => false
    }
    result
  }


}