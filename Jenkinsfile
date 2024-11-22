pipeline {
    agent any
    environment {
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        TFVARS_FILE = credentials('DEV_TFVARS')
    }
    
    stages {
        // stage('Checkout') {
        //     steps {
        //         git branch: 'main', url: 'https://github.com/JohnAgwu/JenkinsProject.git'
        //     }
        // }

        stage('Initialise terraform') {
            steps {
                sh '''
                cd dev
                terraform init
                '''
            }
        }
        
        stage('Terraform Plan') {
            steps {
                sh '''
                cd dev
                terraform plan -var-file=$TFVARS_FILE
                '''
            }
        }
        
        stage('Terraform Apply') {
            steps {
                sh '''
                cd dev
                terraform apply -var-file=$TFVARS_FILE -auto-approve
                '''
            }
        }

        stage('Manage Nginx') {
            environment {
                NGINX_NODE2 = sh(script: "cd dev; terraform output  |  grep nginx_machine_public_dns | awk -F\\=  '{print \$2}'",returnStdout: true).trim()
            }
            steps {
                script {
                    sshagent (credentials : ['SSH-TO-TERRA-Nodes']) {
                        sh """
                        env
                        cd dev
                        ssh ec2-user@${NGINX_NODE2} 'pwd'
                       
                        """
                    }
                }
            }
        }
    }
}
