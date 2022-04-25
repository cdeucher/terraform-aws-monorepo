
## Under construction

```
terraform init
terraform validate

export TF_VAR_db_password="EasyPassword"
## OR
terraform apply -var 'db_password=YetAnotherPassword'

terraform plan -out sc.plan
terraform apply "sc.plan"

terraform output -raw rds_hostname

terraform destroy
```



### This code is based on the following article, with deep changes:
- https://learn.hashicorp.com/tutorials/terraform/aws-rds