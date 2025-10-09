#!/bin/bash

# 🚀 Netflix Movie App - AWS Deployment Script
# This script automates the complete deployment process

set -e  # Exit on any error

# Configuration
REGION="us-east-1"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ECR_REPO="netflix-movie-app"
APP_NAME="netflix-movie-app"
BASELINE_STACK="netflix-baseline"
APP_STACK="netflix-app"

echo "🎬 Starting Netflix Movie App Deployment"
echo "📍 Region: $REGION"
echo "🏢 Account: $ACCOUNT_ID"
echo "📦 ECR Repository: $ECR_REPO"

# Step 1: Create ECR repository if it doesn't exist
echo "📦 Creating ECR repository..."
aws ecr describe-repositories --repository-names $ECR_REPO --region $REGION 2>/dev/null || \
aws ecr create-repository --repository-name $ECR_REPO --region $REGION

# Step 2: Build the application
echo "🏗️ Building React application..."
npm run build

# Step 3: Build and push Docker image
echo "🐳 Building Docker image..."
docker build -t $APP_NAME .

# Login to ECR
echo "🔑 Logging into ECR..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

# Tag and push image
IMAGE_URI="$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$ECR_REPO:latest"
echo "🏷️ Tagging image: $IMAGE_URI"
docker tag $APP_NAME:latest $IMAGE_URI

echo "⬆️ Pushing image to ECR..."
docker push $IMAGE_URI

# Step 4: Deploy baseline infrastructure
echo "🏗️ Deploying baseline infrastructure..."
aws cloudformation deploy \
  --template-file infra/baseline.yaml \
  --stack-name $BASELINE_STACK \
  --capabilities CAPABILITY_IAM \
  --region $REGION \
  --parameter-overrides NamePrefix=netflix

# Step 5: Deploy application stack
echo "🚀 Deploying application stack..."
aws cloudformation deploy \
  --template-file infra/app-stack.yaml \
  --stack-name $APP_STACK \
  --capabilities CAPABILITY_IAM \
  --region $REGION \
  --parameter-overrides NamePrefix=netflix ImageUri=$IMAGE_URI

# Step 6: Get the application URL
echo "🔍 Getting application URL..."
ALB_DNS=$(aws cloudformation describe-stacks \
  --stack-name $APP_STACK \
  --region $REGION \
  --query 'Stacks[0].Outputs[?OutputKey==`AppUrl`].OutputValue' \
  --output text)

echo ""
echo "🎉 Deployment completed successfully!"
echo "🌐 Application URL: $ALB_DNS"
echo "📊 CloudFormation Stacks:"
echo "   - Baseline: $BASELINE_STACK"
echo "   - Application: $APP_STACK"
echo "🐳 Docker Image: $IMAGE_URI"
echo ""
echo "⏰ It may take a few minutes for the service to become healthy."
echo "🔗 Visit $ALB_DNS to see your Netflix Movie App!"