pipeline {
    agent {
        label "jenkins-agent"
    }

    tools{
        jdk 'Java17'
        maven "Maven3"
    }

    stages {
        stage('Clean Up Worskapce') {
            steps {
                //Builtin method for leaning up workspace
                cleansWS()
            }
        }

        stage('Checkout from SCM-github') {
            steps {
                //Builtin method for leaning up workspace
               git branch: 'master', credentialsId: 'github', url: 'https://github.com/ashlesh19/devops_e2e_pipeline'
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
