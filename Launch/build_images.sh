#!/bin/bash

cd Dockerfiles/Spark
docker build -t spark-img .
cd ../Spark-ui
docker build -t spark-ui-img .
# cd ../Hellonode
# docker build -t hello-node:v1 .
cd ../Livy
docker build -t livy-img .
cd ../Jupyter
docker build -t jupyter-img .
cd ../Zeppelin
docker build -t zeppelin-img .
cd ../RStudio
# docker build -t rstudio-img .
cd ../..

# docker images
