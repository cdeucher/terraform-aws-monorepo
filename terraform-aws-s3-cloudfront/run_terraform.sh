#!/bin/bash
environment=$1

if [[ !("$environment" =~ ^(development|staging|production)$) ]]
then
    echo "Ambiente inválido! (ambientes válidos: development, staging ou production)"
    exit 1
fi

terraform workspace select $environment
terraform apply -var-file=./environments/$environment.tfvars