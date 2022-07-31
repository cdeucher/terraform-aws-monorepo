## IAC - Terraform
## Resources - AWS API Gateway + AWS Lambda + AWS DynamoDB + AWS Route53

## Requirements
- [AWS Zone](https://aws.amazon.com/route53/pricing/zone-pricing/) with at least one domain name hosted on it.

## Deployment
- customize the Terraform code to your needs in the `/environments/` directory:
  ```HCL
  accountId = "accountId from AWS IAM, ex. (123498234)"
  domain    = "domain name of the hosted zone, ex. (example.com)"
  ```
  ```
```bash
$ terraform init
$ terraform plan -out plan.tfplan
$ terraform apply plan.tfplan
```

## Testing functions
```bash
$ pytest
```

### API Testing Example

```bash
curl -XPOST 'https://api-dev.<dns>/titles' \
-d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]' \
-H 'Content-Type: application/json'

curl -XPOST 'https://api-gateway.../v1/titles' \
-d  '[{"text": "mushoku","price":"20.01","symbol":"R$","url":"localhost","type":"kindle"}]' \
-H 'Content-Type: application/json'
```