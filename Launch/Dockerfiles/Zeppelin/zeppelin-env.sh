#!/bin/bash

export MASTER="spark://spark-master:7077"
export SPARK_HOME=/opt/spark
export ZEPPELIN_JAVA_OPTS="-Dspark.jars=/opt/spark/lib/gcs-connector-latest-hadoop2.jar"
export CLASSPATH="/opt/spark/lib/gcs-connector-latest-hadoop2.jar"
export ZEPPELIN_NOTEBOOK_DIR="${ZEPPELIN_HOME}/notebook"
export ZEPPELIN_MEM=-Xmx1024m
export ZEPPELIN_PORT=8080
export PYTHONPATH="${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-*.zip"
