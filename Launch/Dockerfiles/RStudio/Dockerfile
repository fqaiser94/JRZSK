FROM rocker/rstudio:latest

RUN apt-get update \
    && apt-get -y install libcurl4-gnutls-dev libssl-dev libxml2-dev

RUN R -e "install.packages(c('sparklyr'))"

RUN R -e "library(sparklyr); spark_install(version = '2.2.0'); livy_install()"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install default-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
