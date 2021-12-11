#!/bin/bash
aws eks --region $1 update-kubeconfig --name $2
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml