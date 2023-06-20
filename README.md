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

```bash 
 aws configure
 ```

$ AWS Access Key ID [None]: <YOUR_AWS_ACCESS_KEY_ID>

$ AWS Secret Access Key [None]: <YOUR_AWS_SECRET_ACCESS_KEY>

$ Default region name [None]: <YOUR_AWS_REGION>

* Proceed to creating a terraform script 

#### The terraform script; poject/main.tf creates all the components of the infrasructure. 
#### <b>project/variables.tf</b> contains all the required variables used in the main terraform script. 
#### The Modules : sg and vpc (contain the scripts for setting up the vpc network snd security groups) are located in the modules/sg and modules/vpc fodlers respectively. 
#### The directories ; modules/ec2 , modules/aws-lb and modules/route53 contain the scripts to create the EC2 instances, Application load Balancer and the Route53 servcice. 
#### <b>These modules contain variables.tf and ouput.tf files that contains the neccesary variables and output values required by the module scripts </b>

* Proceed to run the terraform scripts: Using the the commands below on the terminal 
* Initialize terraform to install neccesary providers 
```bash 
terraform init 
 ```
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





