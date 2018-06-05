FROM spark-img:latest

# Install maven 3.3.9
RUN wget --no-verbose -O /tmp/apache-maven-3.3.9-bin.tar.gz https://www.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
    tar xzf /tmp/apache-maven-3.3.9-bin.tar.gz -C /opt/ && \
    ln -s /opt/apache-maven-3.3.9 /opt/maven && \
    ln -s /opt/maven/bin/mvn /usr/local/bin  && \
    rm -f /tmp/apache-maven-3.3.9-bin.tar.gz

ENV MAVEN_HOME /opt/maven

RUN cd /opt \
    && wget http://www-us.apache.org/dist/incubator/livy/0.5.0-incubating/livy-0.5.0-incubating-bin.zip \
    && unzip livy-0.5.0-incubating-bin.zip \
    && mv livy-0.5.0-incubating-bin livy \
    && mkdir -p livy/logs

ADD livy.conf /opt/livy/conf
# ENV LIVY_HOME /opt/livy/bin

EXPOSE 8998

# ENV SPARK_HOME /opt/spark
# ENV PYSPARK_PYTHON /usr/bin/python3.6
# ENV PYSPARK3_PYTHON /usr/bin/python3.6

CMD opt/livy/bin/livy-server
