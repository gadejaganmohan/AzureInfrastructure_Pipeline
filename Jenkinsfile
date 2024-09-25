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
                            terraform plan -var client_id=${AZURE_CLIENT_ID} \
                                           -var client_secret=${AZURE_CLIENT_SECRET} \
                                           -var tenant_id=${AZURE_TENANT_ID} \
                                           -var subscription_id=${AZURE_SUBSCRIPTION_ID} \
                                           -out=tfplan
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
