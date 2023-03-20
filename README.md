# Using terraform to create a cloud infrastructure on AWS with 3 EC2 Inastances, Vpc and Security group configuration, placing the instances behind a load balancer and AWS Route53 to route the load balancer to a desired domain name. And Using Ansible to install Apache (web-server) on the 3 Instances So they Display the Simple HTML content on all 3 instances.

## Summary
* Create a Teraform script that creates neccesary components of the infrastructure on AWS and exports the public IP addrresss of all instances into /project/host-inventory file 
* Create an ansible script that installs and configures Apache on all the instances 

### Prerequisites :
* AWS account 
* Terraform 
* AWS CLI
* Ansible 

### Steps 

* Having installed the requireed packages on local machine, AWS CLI needs to be configured and logged into with the credentials of an authorized IAM user 

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

* Proceed to run the terraform scripts: Usign the the commands below on the terminal 
* Initialize terraform to install neccesary providers 
```bash 
terraform init 
 ```
* Terraform plan Lays out the events that wil be initiated with the terraform scripts 
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
 
 #### The project/ansible.cfg contains the configuration that specifies the host-inventory files that will be used by ansible and  teh neccesary credentials for configuration management 
 
 *  With the neccesary files for ansible already created and configured, the ansible script; project/main.yaml applies all the configuration for setting up an apache server to the EC2 Instances. 





