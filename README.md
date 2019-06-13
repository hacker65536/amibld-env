# terraform

```console
$ sh tinit.sh                                                         
input info for terraform

region:  us-east-1
name:    hacker
profile: infra-test
prefix: amiblddev


---confirm----
region:  us-east-1
name:    hacker
profile: infra-test
prefix:  amiblddev
--------------
init (y/n)y
wrote to _common/env.auto.tfvars

input github info for codepipeline

github_token:           81fe38********************e309104a9
github_organization:    hacker65536
github_repo:            amibld-runtime
github_branch:(master)


--------confirm---------
github_token:           81fe38********************e309104a9
github_organization:    hacker65536
github_repo:            amibld-runtime
github_branch:          master
init (y/n)y
wrote to codepipeline/github.auto.tfvars

input github info for codebuild

github_token:(same as above)
github_organization:(same as above)
github_repo:                       amibld-playbooks
github_branch:(master)


--------confirm---------
github_token:           81fe38********************e309104a9
github_organization:    hacker65536
github_repo:            amibld-playbooks
github_branch:          master
init (y/n)
```
