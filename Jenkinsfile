pipeline {
    agent any

    environment {
        DOCKERHUB_CRED = credentials('dockerhub-login')
    }

    stages {

        stage('git clone') {
            steps {
                echo 'Checking out repository...'
                git branch: 'main', url: 'https://github.com/aneeshravikumar2002-eng/boxfuse-sample-java-war-hello.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    def mvn = tool 'Default Maven'
                    withSonarQubeEnv('My SonarQube Server') {
                        sh """
                            ${mvn}/bin/mvn clean verify sonar:sonar \
                            -Dsonar.projectKey=box-sonar \
                            -Dsonar.projectName='box-sonar'
                        """
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

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying to Kubernetes...'
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh '''
                        kubectl --kubeconfig=$KUBECONFIG apply -f k8s/deployment.yml
                        kubectl --kubeconfig=$KUBECONFIG apply -f k8s/service.yml
                        kubectl --kubeconfig=$KUBECONFIG rollout status deployment/beautiful-flask-deployment
                    '''
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
