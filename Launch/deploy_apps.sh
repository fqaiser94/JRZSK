#!/bin/bash

# kubectl run hello-node --image=hello-node:v1 --port=8080

kubectl create -f YAMLs/spark-master.yaml
kubectl create -f YAMLs/spark-ui.yaml
kubectl create -f YAMLs/spark-worker.yaml
kubectl create -f YAMLs/livy.yaml
kubectl create -f YAMLs/jupyter.yaml
kubectl create -f YAMLs/zeppelin.yaml
# kubectl create -f YAMLs/rstudio.yaml

kubectl get pods
# kubectl log podName-podId
# kubectl describe pods podName-podId
