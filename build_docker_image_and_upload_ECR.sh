#!/bin/bash

# Set variables
IMAGE_NAME="test"
TAG="$1"  # Use the first command-line argument as the tag value
AWS_REGION="us-east-1"
ECR_REPO_URL="XXXXXXXX.dkr.ecr.us-east-1.amazonaws.com"

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
aws --profile aws-xxxxx-account ecr get-login-password --region "$AWS_REGION" | sudo docker login --username AWS --password-stdin "$ECR_REPO_URL"

# Push Docker image to AWS ECR
sudo docker push "$ECR_REPO_URL/$IMAGE_NAME:$TAG"