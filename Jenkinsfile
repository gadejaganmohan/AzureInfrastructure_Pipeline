 pipeline {
    agent any

    environment {
        AZURE_CREDENTIALS_ID = 'AzureCredentials' // Replace with your Jenkins credentials ID
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Initialize Terraform') {
            steps {
                dir('terraform') {
                    withCredentials([azureServicePrincipal(credentialsId: AzureCredentials)]) {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Plan Infrastructure') {
            steps {
                dir('terraform') {
                    withCredentials([azureServicePrincipal(credentialsId: AzureCredentials)]) {
                        sh 'terraform plan'
                    }
                }
            }
        }

        stage('Apply Infrastructure') {
            steps {
                dir('terraform') {
                    withCredentials([azureServicePrincipal(credentialsId: AzureCredentials)]) {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
