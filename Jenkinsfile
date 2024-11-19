pipeline {
    agent any

    stages {
        stage('Git Pull') {
            steps {
                git 'https://github.com/jayash-k/jenkins-repo'
            }
        }
        stage('Maven Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                echo "Testing with SonarQube"
                withSonarQubeEnv('SonarQube') {  // Ensure 'SonarQube' matches the name in your Jenkins global configuration
                    sh '''
                    mvn clean verify sonar:sonar \
                      -Dsonar.projectKey=myjob \
                      -Dsonar.host.url=http://44.222.225.209:9000 \
                      -Dsonar.login=${SONARQUBE_TOKEN}
                    '''
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                echo "Building Docker Image"
                sh 'docker build -t jayash1845/myproject:latest .'
            }
        }
        stage('Push Docker Image') {
            steps {
                echo "Pushing Docker Image to Registry"
                sh '''
                docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
                docker push jayash1845/myproject:latest
                '''
            }
        }
        stage('Deploy Docker Container') {
            steps {
                echo "Deploying Docker Container"
                sh '''
                docker pull jayash1845/myproject:latest
                docker stop myproject || true
                docker rm myproject || true
                docker run -d --name myproject -p 8081:8081 jayash1845/myproject:latest
                '''
            }
        }
    }

    environment {
        SONARQUBE_TOKEN = credentials('sonarqube-token') // Ensure you have stored your SonarQube token in Jenkins credentials
    }
}
