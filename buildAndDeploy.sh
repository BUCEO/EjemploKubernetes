#!/bin/bash

VERSION=$1 

echo $VERSION

docker build . -t 192.168.5.3:5000/kubernetes/app:$VERSION
docker push 192.168.5.3:5000/kubernetes/app:$VERSION


kubectl apply -f kube/Namespace.yml
kubectl apply -f kube/Servicio.yml
kubectl apply -f kube/LoadBalancer.yml
kubectl apply -f kube/Deployment.yml

kubectl --record deployment/aplicacion set image aplicacion=192.168.5.3:5000/kubernetes/app:$VERSION
