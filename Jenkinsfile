pipeline {
    agent any

    stages {

        stage('Init Repo Protection') {
            when {
                expression { fileExists('.jenkins/first-run.flag') }
            }
            steps {
                script {
                    // JOB_NAME usually looks like "org/repo"
                    def parts    = env.JOB_NAME.tokenize('/')
                    def orgName  = parts.size() > 1 ? parts[0] : ''
                    def repoName = parts.last()

                    withCredentials([usernamePassword(credentialsId: 'github-creds', usernameVariable: 'ADMIN_USER', passwordVariable: 'GITHUB_TOKEN')]) {
                        sh """
                            chmod +x branch-protection.sh
                            ./branch-protection.sh ${repoName} ${ADMIN_USER} ${GITHUB_TOKEN} ${orgName}
                            rm .jenkins/first-run.flag
                            git config --global user.name "Jenkins Automation"
                            git config --global user.email "jenkins@${orgName}.local"
                            git rm .jenkins/first-run.flag || true
                            git commit -m "Remove first-run flag after branch protection setup" || true
                            git push https://${ADMIN_USER}:${GITHUB_TOKEN}@github.com/${orgName}/${repoName}.git HEAD:main || true
                        """
                    }
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
