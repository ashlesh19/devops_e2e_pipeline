pipeline {
    agent {
        label "jenkins-agent"
    }

    tools{
        maven "Maven3"
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
