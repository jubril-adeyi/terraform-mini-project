# Infrastructure provisioning on AWS using terraform and System configuration using Ansible. 

This repository contains terraform code for Provisioning infrastructure and create resources on AWS cloud. this architecture will consist of :
* A VPC network with 3 subnets in three availability zones
* 3 Ec2 instances 
* An Application load balancer 
* 2 Security groups for the Application Load Balancer and the Ec2 Instances
* Route53 service for serving a public DNS that will be routed to the Application load balancer. 
Also, terraform code to create an host-inventory file; containing Ip addresses of the provisioned ec2 instances.  

Ansible code for System configuration on the provisioned instances to set up the servers with the following : 

* Configuration of an Apache web-server with HTML content that identifies the hostname of each server; This is to demonstrate the load balancer functioning. 
# Prerequisites

* AWS account, IAM credentials with necessary permissions to provision resources
* AWS CLI Installed on your machine 
* Terraform Installed on your machine 
* Ansible Installed on your machine 

# Getting started 

Follow these steps to get started with provisioning the infrastructure using Terraform. 

* Clone this repository to your local machine : 
`git clone `
* Cd into cloned the directory 
`cd terraform-mini-project`
* Cd into the /project directory 
`cd /project`

* Initialize terraform by running the following command :
`terraform init `
* Terraform plan displays the events that wil be initiated with the terraform scripts 
* 
```bash 
terraform plan 
 ```
* Terraform apply Starts and completes the creation of the infrastrcture

 ```bash 
terraform apply
 ```



* Now that the infrastructre has been provisoned, Proceed to creating Ansible script to install and set up Apache om the target EC2 instances 

#### In the project/main.tf file the script below exports the public ip address of the Instances into the project/host-inventory file.

```bash 
resource "local_file" "host-inventory" {
  filename = "host-inventory"
  content = <<EOT
  ${aws_instance.server[0].public_ip}
  ${aws_instance.server[1].public_ip}
  ${aws_instance.server[2].public_ip}
    EOT
}
 ```
 #### This inventory file is required  by ansible to target the instances for configuration 
 
 #### The project/ansible.cfg contains the configuration that specifies the host-inventory files that will be used by ansible and the neccesary credentials for configuration management 
 
 *  With the neccesary files for ansible already created and configured, the ansible script; project/main.yaml applies all the configuration for setting up an apache server to the EC2 Instances. 





