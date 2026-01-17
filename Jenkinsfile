pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // If using local unzip, skip git clone
                dir('fullstack-hy2020.github.io') {
                    echo "Using local project files"
                }
            }
        }

        stage('Build React App') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t react-app:latest .'
            }
        }

        stage('Deploy to Minikube') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
                sh 'kubectl apply -f k8s/service.yaml'
            }
        }
    }
}
