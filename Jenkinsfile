pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'cd backend && npm install'
            }
        }
        stage('Test') {
            steps {
                sh 'cd backend && npm test'
            }
        }
        stage('Deploy with Ansible') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'deploy-key', keyFileVariable: 'KEY')]) {
                    sh '''
                    export ANSIBLE_HOST_KEY_CHECKING=False
                           printf "%s" "$KEY" > /tmp/deploy-key.pem
                           chmod 600 /tmp/deploy-key.pem
                           ansible-playbook -i ansible/inventory ansible/deploy-backend.yml --private-key /tmp/deploy-key.pem
                    rm /tmp/deploy-key.pem
                    '''
                }
            }
        }
    }
}