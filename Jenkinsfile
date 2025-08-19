
pipeline {
    agent any
    
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/george-848/boxfuse-sample-java-war-hello.git'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Deploy to Tomcat') {
            steps {
                sh 'sudo cp /var/lib/jenkins/workspace/job1/target/hello-1.0.war /home/ubuntu/apache-tomcat-9.0.108/webapps'
            }
        }
    }
}
