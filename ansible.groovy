pipeline {
    agent any

    stages {
        stage('Git clone') {
            steps {
                git branch: 'dev', url: 'https://github.com/zarembity/devops-final-homework.git'
            }
        }

        stage('Deploy') {
            steps {
                ansiblePlaybook become: true, installation: 'myansible', playbook: 'my_playbook.yml'
            }
        }
    }
}
