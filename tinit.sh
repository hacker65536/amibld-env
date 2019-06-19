#!/bin/env bash

set -e

. ./color

alias t=terraform
envvarfile=_common/env.auto.tfvars
githubvarfile1=codepipeline/github.auto.tfvars
githubvarfile2=codebuild/github.auto.tfvars
sshkey=codebuild/key_pair



if [[ ! -e $envvarfile ]]; then


	echo -e "input info for ${RED}terraform${NOCOLOR}\n"
	read -p 'region:  ' region
	read -p 'name:    ' name
	read -p 'profile: ' profile
	read -p 'prefix: ' prefix

	echo 
	echo
	echo "---confirm----"
	echo "region:  ${region:=us-east-1}"
	echo "name:    $name"
	echo "profile: $profile"
	echo "prefix:  $prefix"
	echo "--------------"

	read -p 'init (y/n)' key

	if [[ "$key" != "y" ]]; then
		echo "aborted"
		exit 0
	fi

	cat <<EOF > $envvarfile
region = "$region"
profile = "$profile"
author = "$name"
EOF
echo -e "wrote to $envvarfile\n"

fi

if [[ ! -e $githubvarfile1 ]]; then


	echo -e "input github info for ${GREEN}codepipeline${NOCOLOR}\n"
	read -p 'github_token:           ' token
	read -p 'github_organization:    ' org
	read -p 'github_repo:            ' repo
	read -p 'github_branch:(master)  ' branch

	echo 
	echo
	echo "--------confirm---------"
	echo "github_token:           $token"
	echo "github_organization:    $org"
	echo "github_repo:            $repo"
	echo "github_branch:          ${branch:=master}"

	read -p 'init (y/n)' key
	if [[ "$key" != "y" ]]; then
		echo "aborted"
		exit 0
	fi

	cat <<EOF > $githubvarfile1
github_token = "$token"
github_organization = "$org"
github_repo = "$repo"
github_branch = "$branch"
EOF
echo -e "wrote to $githubvarfile1\n"

fi

if [[ ! -e $githubvarfile2 ]]; then


	echo -e "input github info for ${PURPLE}codebuild${NOCOLOR}\n"
	read -p 'github_token:(same as above)       ' token2
	read -p 'github_organization:(same as above)' org2
	read -p 'github_repo:                       ' repo2
	read -p 'github_branch:(master)             ' branch2

	echo 
	echo
	echo "--------confirm---------"
	echo "github_token:           ${token2:=$token}"
	echo "github_organization:    ${org2:=$org}"
	echo "github_repo:            ${repo2}"
	echo "github_branch:          ${branch2:=master}"

	read -p 'init (y/n)' key
	if [[ "$key" != "y" ]]; then
		echo "aborted"
		exit 0
	fi

	cat <<EOF > $githubvarfile2
github_token = "$token2"
github_organization = "$org2"
github_repo = "$repo2"
github_branch = "$branch2"
EOF
echo  "wrote to $githubvarfile2"
	cat <<EOF > codebuild/credentials.json
{
  "serverType": "GITHUB",
  "authType": "PERSONAL_ACCESS_TOKEN",
  "token": "$token2"
}
EOF

opt="${profile:+--profile ${profile}} ${region:+--region ${region}}"
aws $opt codebuild import-source-credentials --cli-input-json file://codebuild/credentials.json && \
echo -e "${ORANGE}imported to aws${NOCOLOR}\n" 
aws $opt codebuild list-source-credentials

fi


if [[ ! -e $sshkey ]]; then
	ssh-keygen -t rsa -N "" -C "" -f $sshkey
	echo -e "${ORANGE}create key_pair for packer${NOCOLOR}"
fi

function initbackend(){
	echo
	printbule "init backend"
	echo
	cd backend  
	t init 
	t workspace new $prefix 
	t apply -var="remote_state_bucket=null" -auto-approve
	cat <<<'remote_state_bucket = "'$(t output bucket)'"' >> env.auto.tfvars
}

function initbase(){
	echo
	printbule "init base"
	echo
	cd base 
	sh inittf.sh 
	t apply -auto-approve
}

function initecr(){
	echo
	printbule "init ecr"
	echo
	cd ecr
	sh inittf.sh 
	t apply -auto-approve
}

function initcodepipeline(){
	echo
	printbule "init codepipeline"
	echo
	cd codepipeline
	sh inittf.sh 
	t apply -auto-approve
}

function initcodebuild(){
	echo
	printbule "init codebuild"
	aws ${opt} codebuild list-source-credentials
	echo
	cd codebuild
	sh inittf.sh 
	t apply -auto-approve
}


(initbackend)
(initbase)
(initecr)
(initcodepipeline)
(initcodebuild)

# vim:set foldmethod=marker: #
