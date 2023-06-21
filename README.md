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

## Getting started 

Follow these steps to get started with provisioning the infrastructure using Terraform. 

* Clone this repository to your local machine : 
`git clone `
* Cd into cloned the directory 
`cd terraform-mini-project`
* Cd into the /project directory 
`cd /project`

* Initialize terraform by running the following command :
`terraform init `
* Run the terraform plan command to see Preview the changes that will be applied : 
`terraform plan`
* Now Run the Terraform apply command to apply these changes and provision architecture and resources
 `terraform apply`

## Repository Structure:

This repository contains two main directories: "/modules" and "/project."

1. Modules Directory: The "modules" directory houses reusable Terraform modules for provisioning specific infrastructure components. Each subdirectory within the "modules" directory represents a separate module responsible for creating a particular set of resources. For example, there are modules for VPC network, security groups, Application Load Balancer (ALB), EC2 instances, and Route53 service.

Inside each module subdirectory, you will typically find the following Terraform files:

* variable.tf: This file defines input variables used to customize the behavior of the module.
* outputs.tf: This file specifies the outputs produced by the module, which can be referenced by other parts of the configuration.
* main.tf: This file contains the main Terraform code that provisions the resources defined by the module. It utilizes the input variables and include and the resource definitions.

2. Project Directory: The "project" directory contains the Terraform code responsible for orchestrating the provisioning of resources defined in the "/modules" directory. This code brings together the desired modules and specifies their interactions and dependencies.

The "project" directory also include additional Terraform files:

* variables.tf: This file defines project-level variables that can be used across multiple modules or parts of the configuration.
* main.tf: This file acts as the entry point for the project configuration. It includes the necessary module declarations and  additional resources definitions or configurations. 

Architecture Overview 

The following resources and architecture are provisioned in the us-east-1 region : 

1. An Application load balancer; Serves as entry point for End users. 
2. VPC network; Created, with Multiple subnets in multiple availability zones 
3. Ec2 Instances: Deployed across multiple availability zones and houses web  server application. 
4. Amazon Route53 service: Responsible for serving Host DNS that routes traffic into the Application load balancer 

## System Configurations Using Ansible 

The Terraform code below creates an host-inventory file in the /project directory:
```resource "local_file" "host-inventory" {
  filename = "host-inventory"
  content = <<EOT
  ${aws_instance.server[0].public_ip}
  ${aws_instance.server[1].public_ip}
  ${aws_instance.server[2].public_ip}
    EOT
 ```

This file contains the Ip address of the servers provisioned earlier and is required  for ansible to target the instances for configuration 


Other files necessary for the Ansible configuration includes; the main.yaml file which contains Ansible code to configure the web-servers on the ec2 Instances, and the ansible.cfg file which configures defaults and privilege escalations for the execution of the ansible command

To execute ansible configurations on the servers run this command in the `/project` directory :  ` ansible-playbook -i host-inventory main.yaml`

## Cleaning up 

To clean up the provisioned resources run the following command: `terraform destroy` ,  This will destroy all the resources created by Terraform. Please note that this action is irreversible and will permanently delete the resources.

# Conclusion 

Using Terraform for Infrastructure as Code and Ansible for server configuration ensures a seamless and efficient process. Feel free to modify the code to fit your specific needs, and contributions are welcome.




