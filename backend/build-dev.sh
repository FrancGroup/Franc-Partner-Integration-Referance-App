#!/bin/sh
echo "dev"

docker build . --tag=partner:"dev"
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 686596544118.dkr.ecr.eu-west-1.amazonaws.com

docker tag partner:"dev" 686596544118.dkr.ecr.eu-west-1.amazonaws.com/partner:"dev"
docker push 686596544118.dkr.ecr.eu-west-1.amazonaws.com/partner:"dev"

aws ecs update-service --cluster franc-prod --service partner-api --force-new-deployment | tee