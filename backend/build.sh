#!/bin/sh

version=$(git rev-parse --short=5 HEAD)

echo "$version"

docker build . --tag=partner:"$version"
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 686596544118.dkr.ecr.eu-west-1.amazonaws.com

docker tag partner:"$version" 686596544118.dkr.ecr.eu-west-1.amazonaws.com/partner:"$version"
docker push 686596544118.dkr.ecr.eu-west-1.amazonaws.com/partner:"$version"

