# [Voltar](../README.md)


### Summary

Lets create a workspace for dev.
```bash
terraform workspace new dev
terraform workspace select dev
terraform init
```

This repository will create the following resources:
- S3 Bucket
- CloudFront Distribution

```bash
terraform plan -var-file="environments/dev.tfvars"
terraform apply -var-file="environments/dev.tfvars"
```

Commands:
```bash
terraform state list
terraform state list -module=module-one
terraform state rm aws_s3_bucket_object.current
terraform plan -var="varnew=123"
terraform plan -target=aws_iam_role.ecs_task_role
terraform plan -out sc.tfplan
terraform apply sc.tfplan
terraform apply sc.tfplan -auto-approve
terraform destroy -auto-approve
```