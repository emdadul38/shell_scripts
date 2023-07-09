#!/bin/bash

# Set variables
IMAGE_NAME="test"
ECR_REPO_URL="XXXXXXX.dkr.ecr.us-east-1.amazonaws.com"
TAG_FILE_PATH="docker_tag_history.txt"
IMAGE_URL="$ECR_REPO_URL/$IMAGE_NAME"
CURRENT_DATETIME=$(date +"%Y-%m-%d %H:%M:%S")

# Backup the original file content
original_file_content=$(cat "$TAG_FILE_PATH")

# Append the tag value top to the tag history file
echo -e "$TAG :: $CURRENT_DATETIME [dev]\n$original_file_content" > "$TAG_FILE_PATH"

# current directory
current_dir=$(pwd)

MANIFEST_FILE="$current_dir/folder/k8s-workload.yaml"

echo "Execute the image:: $IMAGE_URL:$TAG"

# Replace the placeholder with the actual image url
sed -i "s|\($IMAGE_URL:\).*|\1$TAG|g" "$MANIFEST_FILE"

# apply the manifest file using kubectl
kubectl apply -f "$MANIFEST_FILE"

# Show the pods
kubectl get pods
