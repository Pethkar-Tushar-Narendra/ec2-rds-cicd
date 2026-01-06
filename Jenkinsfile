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
                withCredentials([sshUserPrivateKey(credentialsId: 'deploy-key', keyFileVariable: 'KEYFILE')]) {
                    sh '''
                        export ANSIBLE_HOST_KEY_CHECKING=False
                        chmod 600 "$KEYFILE"
                        ansible-playbook -i ansible/inventory ansible/deploy-backend.yml --private-key "$KEYFILE"
                    '''
                }
            }
        }
    }
}