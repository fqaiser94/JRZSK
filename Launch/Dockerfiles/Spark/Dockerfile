FROM ubuntu:18.04

ENV hadoop_ver 2.7.6
ENV hadoop_ver_short 2.7
ENV spark_ver 2.2.0

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV JRE_HOME /usr/lib/jvm/java-8-oracle/jre

RUN apt-get update \
    && apt-get install -y vim unzip software-properties-common \
    && add-apt-repository ppa:webupd8team/java \
    && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
    && apt-get update \
    && apt-get install -y --no-install-recommends oracle-java8-installer \
    && apt-get install -y --no-install-recommends oracle-java8-set-default \
    && apt-get install -y curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt && \
    cd /opt && \
    curl http://www.us.apache.org/dist/hadoop/common/hadoop-${hadoop_ver}/hadoop-${hadoop_ver}.tar.gz | \
        tar -zx hadoop-${hadoop_ver}/lib/native && \
    ln -s hadoop-${hadoop_ver} hadoop && \
    echo Hadoop ${hadoop_ver} native libraries installed in /opt/hadoop/lib/native

RUN mkdir -p /opt && \
    cd /opt && \
    curl http://www.us.apache.org/dist/spark/spark-${spark_ver}/spark-${spark_ver}-bin-hadoop${hadoop_ver_short}.tgz | \
        tar -zx && \
    ln -s spark-${spark_ver}-bin-hadoop${hadoop_ver_short} spark && \
    echo Spark ${spark_ver} installed in /opt

RUN cd /opt/spark/jars && \
    curl -O https://storage.googleapis.com/hadoop-lib/gcs/gcs-connector-latest-hadoop2.jar

ADD log4j.properties /opt/spark/conf/log4j.properties
ADD core-site.xml /opt/spark/conf/core-site.xml
ADD start-common.sh start-worker.sh start-master.sh /

RUN chmod +x \
  ./start-common.sh \
  ./start-master.sh \
  ./start-worker.sh

ENV PATH $PATH:/opt/spark/bin
ENV SPARK_HOME /opt/spark
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip
ENV SPARK_OPTS --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info

# Get Python3
RUN add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install python3.6

ENV PYSPARK_PYTHON /usr/bin/python3.6

# Get R
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y r-base
