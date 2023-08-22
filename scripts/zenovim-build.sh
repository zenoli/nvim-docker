#!/bin/bash
tag=${1:-arch}
image="zenoli/zenovim:$tag"
dockerfile="Dockerfile.$tag"

echo "Building image $image from $dockerfile..."
docker build -t $image -f $dockerfile .
echo "DONE"
