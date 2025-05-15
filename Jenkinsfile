pipeline {
    agent any

    environment {
        VENV = "${WORKSPACE}/venv"
    }

    stages {
        stage('Set Up Python Environment') {
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

        stage('Kill Existing Flask App') {
            steps {
                sh '''
                    if screen -list | grep -q flaskapp; then
                        screen -S flaskapp -X quit
                    fi
                '''
            }
        }

        stage('Run Flask App in Screen') {
            steps {
                sh '''
                    . ${VENV}/bin/activate
                    screen -dmS flaskapp bash -c 'python3 app.py'
                '''
            }
        }

        stage('Verify Running') {
            steps {
                sh '''
                    sleep 3
                    curl -s http://localhost:5000 || echo "App may not be reachable"
                '''
            }
        }
    }
}
