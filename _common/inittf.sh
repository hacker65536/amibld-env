#!/bin/bash

workspace=$(cd ../backend && terraform workspace show)
bucket=$(cd ../backend && terraform output bucket)
region=$(cd ../backend && echo 'var.region' | terraform console)
profile=$(cd ../backend && echo 'var.profile' | terraform console)
dynamodb_table=$(cd ../backend && terraform output dynamodb_table)


<<COMMENT
echo $bucket
echo $region
echo $profile
echo $dynamodb_table
echo $workspace
echo $(basename $(pwd))
COMMENT


rm -rf .terraform


files=(
tags.tf
provider.tf
data.tf
terraform.tf
env.auto.tfvars
)

for i in ${files[@]}
do
ln -s ../_common/${i}
done



terraform init  \
-backend=true \
-backend-config="bucket=$bucket" \
-backend-config="key=terraform_state" \
-backend-config="region=$region" \
-backend-config="profile=$profile" \
-backend-config="dynamodb_table=$dynamodb_table" \
-backend-config="workspace_key_prefix=$(basename $(pwd))" 

terraform workspace select ${workspace} > /dev/null 2>&1 || terraform workspace new ${workspace}
