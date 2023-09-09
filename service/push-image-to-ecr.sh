#!/bin/bash

ACCOUNT="628391396011"
REGION="us-east-1"
REPO="app-repository"

aws ecr get-login-password --region ${REGION} \
    | docker login --username AWS --password-stdin ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com

docker build . --target=prod -t ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/${REPO}

docker push ${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/${REPO}
