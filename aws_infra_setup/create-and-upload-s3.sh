#!/bin/bash
BUCKET_NAME=birds-classfier-model-bucket

AWS_ID=$(aws sts get-caller-identity --query Account --output text | cat)
AWS_REGION=$(aws configure get region)

echo "Creating bucket "
aws s3api create-bucket --acl public-read-write --bucket $BUCKET_NAME --create-bucket-configuration LocationConstraint=$AWS_REGION #--output text >> setup.log

echo "Enable versioning"
aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration status=Enabled

echo "Add model to bucket"
aws s3 cp ../model s3://$BUCKET_NAME/ --recursive