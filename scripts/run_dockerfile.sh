#!/bin/bash

docker run -d ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/test-app:latest -p 8081:8081 -e SECRET_KEY=$1 -e DATABASE_URL=$2 