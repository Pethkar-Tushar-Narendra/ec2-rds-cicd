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
                withCredentials([sshUserKey(credentialsId: 'deploy-key', keyFileVariable: 'KEY')]) {
                    sh '''
                    export ANSIBLE_HOST_KEY_CHECKING=False
                    printf "%s" "$KEY" > /tmp/deploy-key.pem
                    chmod 600 /tmp/deploy-key.pem
                    ansible-playbook -i ansible/inventory [deploy-backend.yml](http://_vscodecontentref_/0) --private-key /tmp/deploy-key.pem
                    rm /tmp/deploy-key.pem
                    '''
                }
            }
        }
    }
}
