pipeline {
    agent any

    environment {
        // Derive org and repo from the Git remote URL
        REMOTE_URL = sh(script: "git config --get remote.origin.url", returnStdout: true).trim()
        ORG  = sh(script: "echo ${REMOTE_URL} | sed -E 's#https://github.com/([^/]+)/.*#\\1#'", returnStdout: true).trim()
        REPO = sh(script: "echo ${REMOTE_URL} | sed -E 's#.*/([^/]+)\\.git#\\1#'", returnStdout: true).trim()
    }

    stages {

        stage('Init Repo Protection') {
            when {
                expression { fileExists('.jenkins/first-run.flag') }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-creds', usernameVariable: 'ADMIN_USER', passwordVariable: 'GITHUB_TOKEN')]) {
                    sh """
                        chmod +x branch-protection.sh
                        ./branch-protection.sh ${REPO} ${ADMIN_USER} ${GITHUB_TOKEN} ${ORG}
                        rm .jenkins/first-run.flag
                        git config --global user.name "Jenkins Automation"
                        git config --global user.email "jenkins@${ORG}.local"
                        git rm .jenkins/first-run.flag || true
                        git commit -m "Remove first-run flag after branch protection setup" || true
                        git push https://${ADMIN_USER}:${GITHUB_TOKEN}@github.com/${ORG}/${REPO}.git HEAD:main || true
                    """
                }
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
            steps { sh './gradlew faasBuild' }
        }

        stage('Docker Push') {
            when {
                allOf {
                    branch 'main'
                    not { expression { fileExists('.jenkins/first-run.flag') } }
                }
            }
            steps { sh './gradlew faasPush' }
        }
    }
}
