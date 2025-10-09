# 🧹 Cleanup Script for Netflix Movie App AWS Resources

param(
    [string]$Region = "us-east-1",
    [string]$EcrRepo = "netflix-movie-app"
)

Write-Host "🧹 Cleaning up Netflix Movie App AWS Resources" -ForegroundColor Yellow
Write-Host "📍 Region: $Region" -ForegroundColor Cyan

# Get AWS Account ID
$AccountId = (aws sts get-caller-identity --query Account --output text)

# Variables
$BaselineStack = "netflix-baseline"
$AppStack = "netflix-app"

try {
    # Step 1: Delete application stack
    Write-Host "🗑️ Deleting application stack: $AppStack" -ForegroundColor Cyan
    aws cloudformation delete-stack --stack-name $AppStack --region $Region
    
    Write-Host "⏳ Waiting for application stack deletion..." -ForegroundColor Yellow
    aws cloudformation wait stack-delete-complete --stack-name $AppStack --region $Region

    # Step 2: Delete baseline stack
    Write-Host "🗑️ Deleting baseline stack: $BaselineStack" -ForegroundColor Cyan
    aws cloudformation delete-stack --stack-name $BaselineStack --region $Region
    
    Write-Host "⏳ Waiting for baseline stack deletion..." -ForegroundColor Yellow
    aws cloudformation wait stack-delete-complete --stack-name $BaselineStack --region $Region

    # Step 3: Delete ECR repository (optional)
    $deleteECR = Read-Host "🤔 Do you want to delete the ECR repository '$EcrRepo'? (y/N)"
    if ($deleteECR -eq 'y' -or $deleteECR -eq 'Y') {
        Write-Host "🗑️ Deleting ECR repository: $EcrRepo" -ForegroundColor Cyan
        aws ecr delete-repository --repository-name $EcrRepo --region $Region --force
    }

    Write-Host ""
    Write-Host "✅ Cleanup completed successfully!" -ForegroundColor Green
    Write-Host "💰 All AWS resources have been removed to avoid charges." -ForegroundColor Green
}
catch {
    Write-Host "❌ Cleanup failed: $_" -ForegroundColor Red
    Write-Host "Please check the AWS Console for any remaining resources." -ForegroundColor Yellow
    exit 1
}