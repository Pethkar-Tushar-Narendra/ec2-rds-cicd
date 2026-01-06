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
        stage('Deploy to EC2') {
            steps {
                // Replace with your EC2 details
                withCredentials([sshUserPrivateKey(credentialsId: 'deploy-key', keyFileVariable: 'KEY')]) {
                    sh '''
                    rsync -avz --no-group --no-times --no-perms -e "ssh -i $KEY -o StrictHostKeyChecking=no" backend/ ubuntu@65.2.63.245:/home/ubuntu/backend/
                    ssh -i $KEY -o StrictHostKeyChecking=no ubuntu@65.2.63.245 "cd /home/ubuntu/backend && npm install && pkill node || true && nohup node index.js &"
                    '''
                }
            }
        }
    }
}
