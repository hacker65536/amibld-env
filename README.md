# terraform

```console
$ alias t=terraform
```

backend
--
configure aws profile,session name, region
```console
$ cd backend/
$ cp ../_common/{tmp_env_auto_tfvars,env.auto.tfvars}
$ vim ../_common/env.auto.tfvars
```


init
```console
$ terraform init
```

set prefix for resources
```console
$ prefix=MyTF
$ terraform workspace new $prefix
```

```console
$ terraform apply 
```

base
--

```console
$ cd ../base
$ sh inittf.sh
```

```console
$ terraform apply 
```

ecr
--

```console
$ cd ../ecr
$ sh inittf.sh
```

```console
$ terraform apply 
```


codepiple
--

```console
$ cd ../codepipeline
$ sh inittf.sh
```
configure github
```console
$ cp tmp_github_auto_tfvars github.auto.tfvars
$ vim github.auto.tfvars
```

```console
$ terraform apply 
```

codebuild
--

```console
$ cd ../codebuild
$ sh inittf.sh
```
configure github
```console
$ cp tmp_github_auto_tfvars github.auto.tfvars
$ vim github.auto.tfvars
```
```console
$ cp import-source-credentials_json import-source-credentials.json
$ vim import-source-credentials.json
```
```console
$ sh import-source-credentials.sh
```

```console
$ terraform apply 
```
