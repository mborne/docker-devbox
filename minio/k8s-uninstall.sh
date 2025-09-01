#!/bin/bash

kubectl -n minio delete ingress minio-api
kubectl -n minio delete ingress minio-console

helm -n minio delete minio
helm -n minio-operator delete operator







