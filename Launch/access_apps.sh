#!/bin/bash

# https://medium.com/google-cloud/tools-that-make-my-life-easier-to-work-with-kubernetes-fce3801086c0


# apt-get install -y jq

pkill kubectl

# Make sure all pods terminated

# put inside of a function that returns counter
# kubectl get pods -o jsonpath="$JSONPATH" | grep "Ready=True"
JSONPATH='{range .items[*]}{@.metadata.name}:{range @.status.conditions[*]}{@.type}={@.status};{end}{end}'
READY_FALSE=$(kubectl get pods -o jsonpath="$JSONPATH" | grep -o "Ready=False" | wc -l)
INITIALIZED_FALSE=$(kubectl get pods -o jsonpath="$JSONPATH" | grep -o "Initialized=False" | wc -l)
PODSCHEDULED_FALSE=$(kubectl get pods -o jsonpath="$JSONPATH" | grep -o "PodScheduled=False" | wc -l)
COUNTER=$((READY_FALSE+INITIALIZED_FALSE+PODSCHEDULED_FALSE))

# echo $(kubectl get pods -o json | jq '."items" | .[]')
echo Were here before the counter

while [  "$COUNTER" -gt 0 ]; do
   sleep 5
   READY_FALSE=$(kubectl get pods -o jsonpath="$JSONPATH" | grep -o "Ready=False" | wc -l)
   INITIALIZED_FALSE=$(kubectl get pods -o jsonpath="$JSONPATH" | grep -o "Initialized=False" | wc -l)
   PODSCHEDULED_FALSE=$(kubectl get pods -o jsonpath="$JSONPATH" | grep -o "PodScheduled=False" | wc -l)
   COUNTER=$((READY_FALSE+INITIALIZED_FALSE+PODSCHEDULED_FALSE))
done

echo Were here after the counter


kportforward() {
ADMINPORT=$(kubectl get svc $1 -o json |jq '.spec.ports[]| select(.name=="'$2'").port')
echo "$ADMINPORT"
POD=$(kubectl get pods --selector $3 \
  -o template --template '{{range .items}}{{.metadata.name}} {{.status.phase}}{{"\n"}}{{end}}' \
  | grep Running | head -1 | cut -f1 -d' ')
echo "$POD"
kubectl port-forward $POD $4:$ADMINPORT & sleep 2
xdg-open http://localhost:$4
}

kportforward spark-ui http component=spark-ui 8080
kportforward livy http component=livy 8998
kportforward jupyter http component=jupyter 8888
kportforward zeppelin http component=zeppelin 8081
kportforward rstudio http component=rstudio 8787

# kubectl exec spark-master-podId -it spark-shell
# kubectl exec spark-master-podId -it pyspark
# kubectl exec spark-master-podId -it sparkR

# Port forward k8s
# $1 pod selector
# $2 local port
# $3 pod port

# kportforward() {
# POD=$(kubectl get pods --selector $1 \
#   -o template --template '{{range .items}}{{.metadata.name}} {{.status.phase}}{{"\n"}}{{end}}' \
#   | grep Running | head -1 | cut -f1 -d' ')
# echo "$POD"
# kubectl port-forward $POD $2:$3 & sleep 2
# xdg-open http://localhost:$2
# }
#
# kportforward component=spark-ui-proxy 8080 80
# kportforward component=livy 8998 8998
# kportforward component=jupyter 8888 8888
# kportforward component=zeppelin 8081 8081
# kportforward component=rstudio 8787 8787



# Port forward k8s
# $1 servicename
# $2 portname
# $3 pod selector
# $4 local port
