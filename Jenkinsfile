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
        stage('Deploy on Server') {
            steps {
                echo "Deploying on Tomcat"
                script {
                    if (isUnix()) {
                        sh 'cp -r /var/lib/jenkins/workspace/myjob/target/studentapp-2.2-SNAPSHOT.war /opt/apache-tomcat-9.0.97/webapps/'
                    } else {
                        bat 'copy /var/lib/jenkins/workspace/myjob/target/studentapp-2.2-SNAPSHOT.war C:\\opt\\apache-tomcat-9.0.97\\webapps\\'
                    }
                }
            }
        }
    }
}
