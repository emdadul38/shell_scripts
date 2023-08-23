#!/bin/bash

# # Set variables
IMAGE_NAME="test"
TAG="$1"  # Use the first command-line argument as the tag value
AWS_REGION="us-east-1"
ECR_REPO_URL="xxxxxx.dkr.ecr.us-east-1.amazonaws.com"

# Validate the tag argument
if [ -z "$TAG" ]; then
  echo "Please provide a tag name."
  exit 1
fi

# Update the tag value in the docker-compose.yml file
sed -i "s|image: $IMAGE_NAME|\0:$TAG|g" docker-compose.yml

# Build Docker image using docker-compose
sudo docker-compose build

# Tag Docker image
sudo docker tag "$ECR_REPO_URL/$IMAGE_NAME" "$ECR_REPO_URL/$IMAGE_NAME:$TAG"

# Log in to AWS ECR
aws --profile aws-xxxx-account ecr get-login-password --region "$AWS_REGION" | sudo docker login --username AWS --password-stdin "$ECR_REPO_URL"

# Push Docker image to AWS ECR
sudo docker push "$ECR_REPO_URL/$IMAGE_NAME:$TAG"

TAG_FILE_PATH="docker_tag_history.txt"
IMAGE_URL="$ECR_REPO_URL/$IMAGE_NAME"
CURRENT_DATETIME=$(date +"%Y-%m-%d %H:%M:%S")

# Backup the original file content
original_file_content=$(cat "$TAG_FILE_PATH")

# Append the tag value top to the tag history file
echo -e "$TAG :: $CURRENT_DATETIME [dev]\n$original_file_content" > "$TAG_FILE_PATH"

current_dir=$(pwd)
# go to the parent directory
cd ../..
# update directory 
updated_dir=$(pwd)

MANIFEST_FILE="$updated_dir/text-workload.yaml"

echo "Execute the image:: $IMAGE_URL:$TAG"

# Replace the placeholder with the actual image url
sed -i "s|\($IMAGE_URL:\).*|\1$TAG|g" "$MANIFEST_FILE"

# apply the manifest file using kubectl
kubectl apply -f "$MANIFEST_FILE"

# Show the pods
kubectl get pods

# Delay for 60 seconds
sleep 60

# new line added
echo -e "\n\n\"kubectl get pods\" output after 60 seconds delay\n\n"

# Show the pods
kubectl get pods
