
## This project aims to provide a simple network infrastructure on AWS for testing. 

---
Will be provided the following resources:
| Resources | Any description |
| --------- | --------------- |
| 2 Instances | t2.micro , each on a different subnet  |
| 1 VPC | 10.0.0.0/16 |
| 2 subnets | private, public |
| 1 NAT gateway | private subnet |
| 1 Internet Gateway |
| 2 Router Tables |
| 2 Elastic IPs | NAT Gateway, public instance |

### Only to illustration purpose
![ilustration](img/demo-tform-aws-vpc.png)


### Make sure you are in the correct workspace
```
terraform workspace new aws-networking-test

##  OR

terraform workspace select aws-networking-test
```

### Let's create the state
```
terraform init
terraform plan -out sc.plan
```

### Apply everything, in other words tell AWS to create the resources
```
terraform apply sc.plan
```
---
### You would probably like to make the private subnet truly private, in which case you need to change the network ACL rules.

+ Edit the inbound rules of the VPC (10.0.0.0/16) to deny all traffic;
+ Create a new ACLs to the VPC (10.0.0.0/16);
  + Update the Inbound rules, Outbound rules (Your taste);
  + Add the Subnet associations to the public subnet;
---
### Finally after finishing...
```
terraform destroy
```


### This code is based on the following article, with deep changes:
   - https://harshitdawar.medium.com/launching-a-vpc-with-public-private-subnet-nat-gateway-in-aws-using-terraform-99950c671ce9