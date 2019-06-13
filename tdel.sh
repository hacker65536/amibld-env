#!/bin/env bash


alias t=terraform
cmd="destroy -auto-approve"




(cd codebuild && t $cmd)
(cd codepipeline && t $cmd)
(cd ecr && t $cmd)
(cd base && t $cmd)
(cd backend && t $cmd)
arn=$(aws codebuild list-source-credentials | jq -r '.[][].arn')
aws codebuild delete-source-credentials --arn $arn
