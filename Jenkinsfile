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
                    withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Plan Infrastructure') {
            steps {
                dir('terraform') {
                    withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Apply Infrastructure') {
            steps {
                dir('terraform') {
                    withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
                        sh 'terraform apply -auto-approve tfplan'
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
