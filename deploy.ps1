# 🚀 Netflix Movie App - PowerShell Deployment Script
# This script automates the complete deployment process for Windows

param(
    [string]$Region = "us-east-1",
    [string]$EcrRepo = "netflix-movie-app",
    [string]$AppName = "netflix-movie-app"
)

Write-Host "🎬 Starting Netflix Movie App Deployment" -ForegroundColor Green
Write-Host "📍 Region: $Region" -ForegroundColor Yellow
Write-Host "📦 ECR Repository: $EcrRepo" -ForegroundColor Yellow

# Get AWS Account ID
$AccountId = (aws sts get-caller-identity --query Account --output text)
Write-Host "🏢 Account: $AccountId" -ForegroundColor Yellow

# Variables
$BaselineStack = "netflix-baseline"
$AppStack = "netflix-app"
$ImageUri = "$AccountId.dkr.ecr.$Region.amazonaws.com/$EcrRepo`:latest"

try {
    # Step 1: Create ECR repository if it doesn't exist
    Write-Host "📦 Creating ECR repository..." -ForegroundColor Cyan
    try {
        aws ecr describe-repositories --repository-names $EcrRepo --region $Region | Out-Null
    }
    catch {
        aws ecr create-repository --repository-name $EcrRepo --region $Region
    }

    # Step 2: Build the application
    Write-Host "🏗️ Building React application..." -ForegroundColor Cyan
    npm run build
    if ($LASTEXITCODE -ne 0) { throw "React build failed" }

    # Step 3: Build and push Docker image
    Write-Host "🐳 Building Docker image..." -ForegroundColor Cyan
    docker build -t $AppName .
    if ($LASTEXITCODE -ne 0) { throw "Docker build failed" }

    # Login to ECR
    Write-Host "🔑 Logging into ECR..." -ForegroundColor Cyan
    $LoginCommand = aws ecr get-login-password --region $Region
    $LoginCommand | docker login --username AWS --password-stdin $AccountId.dkr.ecr.$Region.amazonaws.com
    if ($LASTEXITCODE -ne 0) { throw "ECR login failed" }

    # Tag and push image
    Write-Host "🏷️ Tagging image: $ImageUri" -ForegroundColor Cyan
    docker tag "$AppName`:latest" $ImageUri
    if ($LASTEXITCODE -ne 0) { throw "Docker tag failed" }

    Write-Host "⬆️ Pushing image to ECR..." -ForegroundColor Cyan
    docker push $ImageUri
    if ($LASTEXITCODE -ne 0) { throw "Docker push failed" }

    # Step 4: Deploy baseline infrastructure
    Write-Host "🏗️ Deploying baseline infrastructure..." -ForegroundColor Cyan
    aws cloudformation deploy `
        --template-file infra/baseline.yaml `
        --stack-name $BaselineStack `
        --capabilities CAPABILITY_IAM `
        --region $Region `
        --parameter-overrides NamePrefix=netflix
    if ($LASTEXITCODE -ne 0) { throw "Baseline deployment failed" }

    # Step 5: Deploy application stack
    Write-Host "🚀 Deploying application stack..." -ForegroundColor Cyan
    aws cloudformation deploy `
        --template-file infra/app-stack.yaml `
        --stack-name $AppStack `
        --capabilities CAPABILITY_IAM `
        --region $Region `
        --parameter-overrides NamePrefix=netflix ImageUri=$ImageUri
    if ($LASTEXITCODE -ne 0) { throw "Application deployment failed" }

    # Step 6: Get the application URL
    Write-Host "🔍 Getting application URL..." -ForegroundColor Cyan
    $AlbDns = aws cloudformation describe-stacks `
        --stack-name $AppStack `
        --region $Region `
        --query 'Stacks[0].Outputs[?OutputKey==`AppUrl`].OutputValue' `
        --output text

    Write-Host ""
    Write-Host "🎉 Deployment completed successfully!" -ForegroundColor Green
    Write-Host "🌐 Application URL: $AlbDns" -ForegroundColor Green
    Write-Host "📊 CloudFormation Stacks:" -ForegroundColor Yellow
    Write-Host "   - Baseline: $BaselineStack" -ForegroundColor Yellow
    Write-Host "   - Application: $AppStack" -ForegroundColor Yellow
    Write-Host "🐳 Docker Image: $ImageUri" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "⏰ It may take a few minutes for the service to become healthy." -ForegroundColor Cyan
    Write-Host "🔗 Visit $AlbDns to see your Netflix Movie App!" -ForegroundColor Green
}
catch {
    Write-Host "❌ Deployment failed: $_" -ForegroundColor Red
    exit 1
}