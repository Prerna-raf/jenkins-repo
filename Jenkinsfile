pipeline {
    agent any

    stages {
        stage('Git Pull') {
            steps {
                git 'https://github.com/jayash-k/jenkins-repo.git'
            }
        }
        stage('Maven Build') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'mvn clean package'
                    } else {
                        bat 'mvn clean package'
                    }
                }
            }
        }
        stage('SonarQube Analysis') {
            steps {
                echo "Testing with SonarQube"
                script {
                    sh '''
                    mvn clean verify sonar:sonar \
                      -Dsonar.projectKey=myproject \
                      -Dsonar.host.url=http://54.198.173.47:9000 \
                      -Dsonar.login=sqp_f510600c65ce626c2d67769d67a050ca44d6bc28
                    '''
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                echo "Building Docker Image"
                script {
                    if (isUnix()) {
                        sh 'docker build -t jayash1845/myproject:latest .'
                    } else {
                        bat 'docker build -t jayash1845/myproject:latest .'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                echo "Pushing Docker Image to Registry"
                script {
                    if (isUnix()) {
                        sh '''
                        docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
                        docker push jayash1845/myproject:latest
                        '''
                    } else {
                        bat '''
                        docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%
                        docker push jayash1845/myproject:latest
                        '''
                    }
                }
            }
        }
        stage('Deploy Docker Container') {
            steps {
                echo "Deploying Docker Container"
                script {
                    if (isUnix()) {
                        sh '''
                        docker pull jayash1845/myproject:latest
                        docker stop myproject || true
                        docker rm myproject || true
                        docker run -d --name myproject -p 8081:8081 jayash1845/myproject:latest
                        '''
                    } else {
                        bat '''
                        docker pull jayash1845/myproject:latest
                        docker stop myproject || true
                        docker rm myproject || true
                        docker run -d --name myproject -p 8081:8081 jayash1845/myproject:latest
                        '''
                    }
                }
            }
        }
    }
}
