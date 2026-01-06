pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Install dependencies') {
            steps {
                sh 'cd backend && npm install'
            }
        }
        stage('Deploy with Ansible') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'deploy-key', keyFileVariable: 'KEY')]) {
                    sh 'ansible-playbook -i ansible/inventory ansible/deploy-backend.yml --private-key $KEY'
                }
            }
        }
    }
}
