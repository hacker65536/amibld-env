#!/bin/env bash


alias t=terraform
envvarfile=_common/env.auto.tfvars
githubvarfile1=codepipeline/github.auto.tfvars
githubvarfile2=codebuild/github.auto.tfvars
sshkey=codebuild/key_pair


#{{{
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'
#}}}

if [[ ! -e $envvarfile ]]; then


	echo -e "input info for ${RED}terraform${NOCOLOR}\n"
	read -p 'region:  ' region
	read -p 'name:    ' name
	read -p 'profile: ' profile
	read -p 'prefix: ' prefix

	echo 
	echo
	echo "---confirm----"
	echo "region:  $region"
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

opt=${profile:+"--profile ${profile}"}
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
	t apply -auto-approve
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
	opt=${profile:+"--profile ${profile}"}
	aws ${opt} codebuild list-source-credentials
	echo
	cd codebuild
	sh inittf.sh 
	t apply -auto-approve
}


function printbule(){
	echo -e "${BLUE}$1${NOCOLOR}\n"
}
(initbackend)
(initbase)
(initecr)
(initcodepipeline)
(initcodebuild)

# vim:set foldmethod=marker: #
