pipeline {
    agent any
    environment {
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        TFVARS_FILE = credentials('DEV_TFVARS')
    }

    parameters {
        choice (choices: "ALL\nINFRA\nAPPS", description: " this is to manage pipeline steps", name: "DEPLOY_OPTIONS")
    }
    
    stages {
        // stage('Checkout') {
        //     steps {
        //         git branch: 'main', url: 'https://github.com/JohnAgwu/JenkinsProject.git'
        //     }
        // }

        stage('Initialise terraform') {
            steps {
                script {
                    echo "${params.DEPLOY_OPTIONS}"
                }
                sh '''
                cd dev
                terraform init
                '''
            }
        }
        
        stage('Terraform Plan') {
            when {
                expression  { params.DEPLOY_OPTIONS == 'INFRA' || params.DEPLOY_OPTIONS == 'ALL' }
            }
            steps {
                sh '''
                cd dev
                terraform plan -var-file=$TFVARS_FILE
                '''
            }
        }
        
        stage('Terraform Apply') {
            when {
                expression  { params.DEPLOY_OPTIONS == 'INFRA' || params.DEPLOY_OPTIONS == 'ALL' }
            }
            steps {
                sh '''
                cd dev
                terraform apply -var-file=$TFVARS_FILE -auto-approve
                '''
            }
        }

        stage('Manage Nginx') {
            when {
                expression  { params.DEPLOY_OPTIONS == 'APPS' || params.DEPLOY_OPTIONS == 'ALL' }
            }
            environment {
                NGINX_NODE2 = sh(script: "cd dev; terraform output  |  grep nginx_machine_public_dns | awk -F\\=  '{print \$2}'",returnStdout: true).trim()
            }
            steps {
                script {
                    sshagent (credentials : ['SSH-TO-TERRA-Nodes']) {
                        sh """
                        env
                        cd dev
                        ssh -o StrictHostKeyChecking=no ec2-user@${NGINX_NODE2} 'sudo yum update -y && sudo yum install git -y && sudo yum install nginx -y && sudo systemctl start nginx && sudo systemctl enable nginx'
                        """
                    }
                }
            }
        }

        stage('Manage Python') {
            when {
                expression  { params.DEPLOY_OPTIONS == 'APPS' || params.DEPLOY_OPTIONS == 'ALL' }
            }
            environment {
                PYTHON_NODE = sh(script: "cd dev; terraform output  |  grep python_machine_public_dns | awk -F\\=  '{print \$2}'",returnStdout: true).trim()
            }
            steps {
                script {
                    sshagent (credentials : ['SSH-TO-TERRA-Nodes']) {
                        sh """
                        env
                        cd dev
                        scp -o StrictHostKeyChecking=no ../python.service ec2-user@${PYTHON_NODE}:/tmp
                        scp -o StrictHostKeyChecking=no ../hello.py ec2-user@${PYTHON_NODE}:/tmp
                        ssh -o StrictHostKeyChecking=no ec2-user@${PYTHON_NODE} 'sudo yum update -y; sudo yum install python3 -y; sudo cp /tmp/python.service /etc/systemd/system; sudo systemctl daemon-reload; sudo systemctl restart python.service'
                        """
                    }
                }
            }
        }

        stage ('Notification') {
            steps {
                script {
                    withCredentials ([string (credentialsId: 'SLACK_TOKEN', variable: 'SLACK_ID')]) {

                        sh """
                          curl -X POST \
                          -H 'Authorization: Bearer ${SLACK_ID}' \
                          -H 'Content-Type: application/json' \
                          --data '{"channel": "devops-masterclass-2024","text" : "Hello, testing"}'  \
                          https://slack.com//api/chat.postMessage 
                        """
                    }
                }
            }
        }     
    }

        // stage('Terraform Destroy') {
        //     steps {
        //         sh '''
        //         cd dev
        //         terraform destroy -var-file=$TFVARS_FILE -auto-approve
        //         '''
        //     }
        // }
    }
}
