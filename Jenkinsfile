pipeline {
    agent any

    environment {
        GITHUB_TOKEN = "${env.GITHUB_TOKEN}"
        ADMIN_USER   = "${env.ADMIN_USER}"
        ORG          = "${env.ORG}"
    }

    stages {

        stage('Init Repo Protection') {
            when {
                expression { fileExists('.jenkins/first-run.flag') }
            }
            steps {
                sh """
                    chmod +x branch-protection.sh
                    ./branch-protection.sh ${env.JOB_NAME} ${env.ADMIN_USER} ${env.GITHUB_TOKEN} ${env.ORG}
                    rm .jenkins/first-run.flag
                """
            }
        }

        stage('Checkout') {
            when {
                not { expression { fileExists('.jenkins/first-run.flag') } }
            }
            steps { checkout scm }
        }

        stage('Build') {
            when {
                not { expression { fileExists('.jenkins/first-run.flag') } }
            }
            steps { sh './gradlew build' }
        }

        stage('Docker Push') {
            when {
                allOf {
                    branch 'main'
                    not { expression { fileExists('.jenkins/first-run.flag') } }
                }
            }
            steps { sh './gradlew push' }
        }
    }
}
