FROM spark-img:latest

ENV ZEPPELIN_VER 0.7.3

RUN mkdir -p /opt && \
    cd /opt && \
    curl http://apache.mirror.globo.tech/zeppelin/zeppelin-${ZEPPELIN_VER}/zeppelin-${ZEPPELIN_VER}-bin-all.tgz | \
        tar -zx && \
    ln -s zeppelin-${ZEPPELIN_VER}-bin-all zeppelin && \
    echo Zeppelin ${ZEPPELIN_VER} installed in /opt

ADD zeppelin-log4j.properties /opt/zeppelin/conf/log4j.properties
ADD zeppelin-env.sh /opt/zeppelin/conf/zeppelin-env.sh
ADD docker-zeppelin.sh /opt/zeppelin/bin/docker-zeppelin.sh
RUN chmod +x /opt/zeppelin/bin/docker-zeppelin.sh

EXPOSE 8080

ENTRYPOINT ["/opt/zeppelin/bin/docker-zeppelin.sh"]
