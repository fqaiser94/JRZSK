#!/bin/bash

# $1 environment: minikube or gke
# $2 pods: pods to create
# set defaults for gke cluster creation


# apt-get install kubectl

# launch environment
if [ "$1" == "minikube" ]
then
  echo "minikube environment selected"
  # check for pre-requisites
  MINIKUBE_STATUS="$(minikube status)"
  if echo "${MINIKUBE_STATUS}" | grep -q "minikube:\sRunning"
  then
      echo "minikube already running"
      echo "${MINIKUBE_STATUS}"
      eval $(minikube docker-env)

      kubectl delete svc --all
      kubectl delete rc --all
      kubectl delete pods --all
      RUNNING_PODS_COUNTER=$(kubectl get pods -o json | jq '."items" | .[]' | wc -l)
      while [  "$RUNNING_PODS_COUNTER" -gt 0 ]; do
        sleep 5
        RUNNING_PODS_COUNTER=$(kubectl get pods -o json | jq '."items" | .[]' | wc -l)
      done
  else
    echo "minikube not running, will launch a new minikube instance"
    newgrp libvirtd
    minikube start --vm-driver kvm2
    eval $(minikube docker-env)
  fi
fi

# build images
sh ./build_images.sh

if [ "$1" == "gke" ]
then
  echo "gke environment selected"
  sh ./push_images.sh

  GKE_STATUS="$(gcloud container clusters list | wc -l)"
  if [ "${GKE_STATUS}" -gt 0 ]
  then
      echo "gke cluster already running"

      kubectl delete svc --all
      kubectl delete rc --all
      kubectl delete pods --all

      RUNNING_PODS_COUNTER=$(kubectl get pods -o json | jq '."items" | .[]' | wc -l)
      while [  "$RUNNING_PODS_COUNTER" -gt 0 ]; do
        sleep 5
        RUNNING_PODS_COUNTER=$(kubectl get pods -o json | jq '."items" | .[]' | wc -l)
      done
  else
    echo "gke cluster doesn't exist, will launch a new gke cluster"
    gcloud container clusters create test-k8s-cluster \
    --num-nodes 2 --preemptible \
    --machine-type n1-highmem-2

    gcloud container clusters get-credentials test-k8s-cluster
  fi
fi

# deploy images
sh ./deploy_apps.sh

# access apps
sh ./access_apps.sh

# clean up port forwarding
# l5clean(){lsof -t -i tcp:9000 | xargs kill}



# mainmenu () {
#   echo "Press x to exit the script"
#   read  -n 1 -p "Input Selection:" mainmenuinput
#   if [ "$mainmenuinput" = "x" ];
#   then
#     exit
#   else
#     echo "You have entered an invalid selection!"
#     echo "Please try again!"
#     echo ""
#     echo "Press any key to continue..."
#     read -n 1
#     clear
#     mainmenu
#   fi
# }
#
# mainmenu
