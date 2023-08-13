pipeline {
    agent {
        label "agent01"
    }

    tools {
        terraform 'terraform'
    }
    stages {
        stage('Deploy infrastructure') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'aws-access-key', passwordVariable: 'aws-secret-key', usernameVariable: 'aws-access-key')]) {
                        // define AWS credentials
                        def awsAccessKeyId = env.'aws-access-key'
                        def awsSecretAccessKey = env.'aws-secret-key'
                        
                        //set AWS credentials 
                        sh 'aws --version'
                        sh "aws configure set aws_access_key_id ${awsAccessKeyId}"
                        sh "aws configure set aws_secret_access_key ${awsSecretAccessKey}"
                        sh "aws configure set region 'us-east-1'"

                        // Retrieve other required environment variables
                        def awsRegion = sh(returnStdout: true, script: 'aws configure get region').trim()
                        def bucketName = 'terraformbucket'

                        // Create infra using Terraform
                        dir('project'){sh " terraform init \
                            -var 'access_key=${awsAccessKeyId}' \
                            -var 'secret_key=${awsSecretAccessKey}' "
                        sh " terraform plan\
                            -var 'access_key=${awsAccessKeyId}' \
                            -var 'secret_key=${awsSecretAccessKey}' "
                        sh " terraform destroy --auto-approve \
                            -var 'access_key=${awsAccessKeyId}' \
                            -var 'secret_key=${awsSecretAccessKey}' "
                        sh " cat host-inventory "
                        }
                    }
                }
            }
        }
        stage('Ansible System-configuration'){
            steps{
                dir('project'){ ansiblePlaybook credentialsId: 'key.pem', disableHostKeyChecking: true, installation: 'ansible', inventory: 'host-inventory', playbook: 'main.yaml'}
                }
            }
    }
}