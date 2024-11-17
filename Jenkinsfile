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
                withSonarQubeEnv('SonarQube') {
                    script {
                        sh '''
                        mvn clean verify sonar:sonar \
                          -Dsonar.projectKey=myjob \
                          -Dsonar.host.url=http://98.81.150.14:9000 \
                          -Dsonar.login=sqp_ff658443f61359a1983910b25691bed7950f8aa6
                        '''
                    }
                }
            }
        }
        stage('Deploy on Server') {
            steps {
                echo "Deploying on Tomcat"
                script {
                    sh '''
                    cp -r /var/lib/jenkins/workspace/demo/target/studentapp-2.2-SNAPSHOT.war /opt/apache-tomcat-9.0.97/webapps/
                    '''
                }
            }
        }
    }
}
