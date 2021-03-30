pipeline {

    environment {
        registry = "gruzii/hellowrld2"
        dockerImage = ''
        registryCredential = 'fbb3e1da-574e-414b-baae-5661250feccb'
    }

    agent any

    stages {

        stage('git clone') {
            steps {
                git branch: 'dev', url: 'https://github.com/zarembity/devops-final-homework.git'
            }
        }

        stage('Building image') {
          steps{
            script {
              dockerImage = docker.build registry + ":$BUILD_NUMBER"
            }
          }
        }

        stage('Push image') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Remove Unused docker image') {
          steps{
            sh "docker rmi $registry:$BUILD_NUMBER"
          }
        }
        stage('deploy') {
            steps {
                ansiblePlaybook become: true, installation: 'myansible', playbook: 'aws-playbook.yml'
            }
        }
    }

}
