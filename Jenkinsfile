pipeline {
    agent any
    stages {
        stage('git pull') { 
            steps {
                git 'https://github.com/jayash-k/jenkins-repo.git'
            }
        }
        stage('mvn build') { 
            steps {
                sh 'mvn clean package'
            }
        }
        stage('sonar test') { 
            steps {
                echo "Testing with SonarQube"
                sh '''
                    mvn clean verify sonar:sonar \
                    -Dsonar.projectKey=mykey \
                    -Dsonar.host.url=http://51.20.120.115:9000 \
                    -Dsonar.login=sqp_9cd4952029d9169ad64e6acf30bdb038072154af
                '''
            }
        }
        stage('deploy') {
            steps {
                echo "Deploying on tomcat "
                sh '''
                    cp -r /var/lib/jenkins/workspace/demo/target/*.war /root/apache-tomcat-8.5.99/webapps/
                '''
            }
        }
    }
}
