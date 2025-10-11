pipeline {
    agent any

    environment {
        DOCKERHUB_CRED   = credentials('dockerhub-login')   // Docker Hub credentials
        SONAR_TOKEN_CRED = credentials('sonar-token')       // SonarQube token
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo 'Checking out repository...'
                git branch: 'main', url: 'https://github.com/aneeshravikumar2002-eng/boxfuse-sample-java-war-hello.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo 'Running SonarQube analysis...'
                script {
                    // Use the Maven installation configured in Jenkins
                    def mvnHome = tool name: 'Default Maven', type: 'maven'

                    // 'MySonarQube' should be replaced with your SonarQube installation name in Jenkins
                    withSonarQubeEnv('MySonarQube') {
                        sh "${mvnHome}/bin/mvn clean verify sonar:sonar " +
                           "-Dsonar.projectKey=box-sonar " +
                           "-Dsonar.projectName='box-sonar'"
                    }
                }
            }
        }

        stage('Build WAR') {
            steps {
                echo 'Building the WAR package...'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh """
                    docker build -t aneesh292002/box-app:${BUILD_NUMBER} \
                                 -t aneesh292002/box-app:latest .
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                echo 'Running Docker container...'
                sh """
                    docker stop box-app || true
                    docker rm box-app || true
                    docker run -d --name box-app -p 5002:5000 aneesh292002/box-app:latest
                """
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing image to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-login', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push aneesh292002/box-app:${BUILD_NUMBER}
                        docker push aneesh292002/box-app:latest
                        docker logout
                    """
                }
            }
        }
    }

    post {
        failure {
            echo 'Build failed. Check logs for details.'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
    }
}

