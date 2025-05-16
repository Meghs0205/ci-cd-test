pipeline {
    agent any

    stages {
        stage('Setup Python Env') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install flask
                '''
            }
        }

        stage('Restart Flask Service') {
            steps {
                sh '''
                    sudo systemctl restart flaskapp
                '''
            }
        }
    }
}
