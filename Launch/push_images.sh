#!/bin/bash

docker tag spark-img gcr.io/summer-surfer-203320/spark-img:latest
docker push gcr.io/summer-surfer-203320/spark-img

docker tag spark-ui-img gcr.io/summer-surfer-203320/spark-ui-img:latest
docker push gcr.io/summer-surfer-203320/spark-ui-img

docker tag livy-img gcr.io/summer-surfer-203320/livy-img:latest
docker push gcr.io/summer-surfer-203320/livy-img

docker tag jupyter-img gcr.io/summer-surfer-203320/jupyter-img:latest
docker push gcr.io/summer-surfer-203320/jupyter-img

# docker tag rstudio-img gcr.io/summer-surfer-203320/rstudio-img:latest
# docker push gcr.io/summer-surfer-203320/rstudio-img

docker tag zeppelin-img gcr.io/summer-surfer-203320/zeppelin-img:latest
docker push gcr.io/summer-surfer-203320/zeppelin-img
