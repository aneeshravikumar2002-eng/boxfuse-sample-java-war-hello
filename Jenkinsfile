pipeline {
    agent any

    environment {
        DOCKERHUB_CRED   = credentials('dockerhub-login')   // Docker Hub credentials
        SONAR_TOKEN_CRED = credentials('sonar-token')      // SonarQube token credential
        SONAR_HOST_URL   = 'http://13.126.80.41:9000/' // Replace with your SonarQube URL
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo 'Checking out repository...'
                git branch: 'main', url: 'https://github.com/aneeshravikumar2002-eng/boxfuse-sample-java-war-hello.git'
            }
        }

        stage('Build & SonarQube Analysis') {
            steps {
                echo 'Building WAR and running SonarQube analysis...'
                sh """
                docker run --rm -v $WORKSPACE:/usr/src/mymaven -w /usr/src/mymaven maven:3.9.2-openjdk-17 bash -c \\
                "mvn clean verify sonar:sonar \\
                    -Dsonar.projectKey=flask-sonar \\
                    -Dsonar.projectName=flask-sonar \\
                    -Dsonar.host.url=${SONAR_HOST_URL} \\
                    -Dsonar.login=${SONAR_TOKEN_CRED} \\
                    -Dsonar.java.binaries=target/classes"
                """
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

