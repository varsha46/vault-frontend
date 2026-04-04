pipeline {
    agent any

    stages {
        stage('Clone Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/varsha46/vault-frontend.git'
            }
        }

        stage('Deploy to Frontend EC2') {
            steps {
                sh '''
                    scp -i /var/lib/jenkins/task-key.pem \
                        -o StrictHostKeyChecking=no \
                        -o ProxyCommand="ssh -i /var/lib/jenkins/task-key.pem -o StrictHostKeyChecking=no -W %h:%p ec2-user@13.201.54.222" \
                        index.html \
                        ec2-user@10.0.1.68:/var/app/current/index.html
                '''
            }
        }

        stage('Reload Nginx') {
            steps {
                sh '''
                    ssh -i /var/lib/jenkins/task-key.pem \
                        -o StrictHostKeyChecking=no \
                        -o ProxyCommand="ssh -i /var/lib/jenkins/task-key.pem -o StrictHostKeyChecking=no -W %h:%p ec2-user@13.201.54.222" \
                        ec2-user@10.0.1.68 \
                        "sudo systemctl restart nginx"
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Frontend deployed successfully!'
        }
        failure {
            echo '❌ Frontend deployment failed!'
        }
    }
}