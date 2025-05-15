pipeline {
    agent any

    environment {
        VENV = "${WORKSPACE}/venv"
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh '''
                    sudo apt-get update
                    sudo apt-get install -y screen
                    python3 -m venv ${VENV}
                    . ${VENV}/bin/activate
                    pip install --upgrade pip
                    pip install flask
                '''
            }
        }

        stage('Stop Old App If Running') {
            steps {
                sh '''
                    if screen -list | grep -q flaskapp; then
                        screen -S flaskapp -X quit
                    fi
                '''
            }
        }

        stage('Start Flask App') {
            steps {
                sh '''
                    . ${VENV}/bin/activate
                    screen -dmS flaskapp bash -c 'python3 app.py'
                '''
            }
        }

        stage('Check If Running') {
            steps {
                sh '''
                    sleep 5
                    curl -s http://localhost:5000 || echo "Flask app may not be responding yet."
                '''
            }
        }
    }
}
