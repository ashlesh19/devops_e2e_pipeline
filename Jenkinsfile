pipeline {
    agent {
        label "jenkins-agent"
    }

    tools{
        maven "Maven3"
    }
    environment{
        APP_NAME = "devops_e2e_pipeline"
        RELEASE = "1.0.0"
        DOCKER_USER = "ashlesh1910"
        DOCKER_PASS = 'dockerhub-token'
        IMAGE_NAME = "${DOCKER_USER}"+ "/" +"${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
        JENKINS_API_TOKEN = credentials('JENKINS_API_TOKEN')
    }

    stages {
        stage('Clean Up Worskapce') {
            steps {
                //Builtin method for leaning up workspace
                deleteDir()
            }
        }

        stage('Checkout from SCM-github') {
            steps {
                //SCM used to fetch our jenkins file 
               git branch: 'master', credentialsId: 'github', url: 'https://github.com/ashlesh19/devops_e2e_pipeline'
            }
        }
               
        
         stage("Build Application"){
            steps {
                sh "mvn clean package"
            }

        }

        stage("Test Application"){
            steps {
                sh "mvn test"
            }
        }
        
        stage("Sonarqube Analysis"){
            steps {
                script{
                    withSonarQubeEnv(credentialsId: 'sonarqube-token'){
                    sh "mvn sonar:sonar"
                    }
                }
            }
        }

        stage("Quality Gate") {
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonarqube-token'
                }
            }

        }
        
        stage("Build & Push Docker Image") {
            steps {
                script {
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }

                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }

        }

        stage("Trigger CD pipeline") {
            steps {
                script {
                    sh "curl -v -k --user admin:${JENKINS_API_TOKEN} -X POST -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' --data 'IMAGE_TAG=${IMAGE_TAG}' 'https://52.73.246.45/job/devops-manifest-pipeline/buildWithParameters?token=manifest-token'"
                }
            }

        }

    }

    // post {
    //     always {
    //         // Cleanup steps, notifications, etc.
    //         sh 'echo "Pipeline finished"'
    //     }
    //     success {
    //         // Actions to take on success
    //         sh 'echo "Pipeline succeeded"'
    //     }
    //     failure {
    //         // Actions to take on failure
    //         sh 'echo "Pipeline failed"'
    //     }
    // }
}
