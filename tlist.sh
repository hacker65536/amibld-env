#!/bin/env bash

. ./color

alias t=terraform
cmd="state list"



printbule "backend"
(cd backend && t $cmd)
echo
printbule "base"
(cd base && t $cmd)
echo
printbule "ecr"
(cd ecr && t $cmd)
echo
printbule "codepipeline"
(cd codepipeline && t $cmd)
echo
printbule "codebuild"
(cd codebuild && t $cmd)
echo
