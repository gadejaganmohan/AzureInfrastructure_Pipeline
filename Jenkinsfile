pipeline {
    agent any

    environment {
        AZURE_CREDENTIALS_ID = 'AzureCredentials' // This is the ID of the credentials you added in Jenkins
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
                    // Using the Azure Service Principal credentials stored in Jenkins
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
                        // Passing the credentials securely to Terraform as environment variables
                        sh '''
                            terraform plan -out=tfplan
                        '''
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
