#!/bin/bash

helm -n minio delete minio
kubectl delete namespace minio


