pipeline {
    agent any

    environment {
        VENV = "${WORKSPACE}/venv"
        LOG_FILE = "${WORKSPACE}/flask.log"
        PID_FILE = "${WORKSPACE}/flask.pid"
    }

    stages {
        stage('Install Flask & Setup venv') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install flask
                '''
            }
        }

        stage('Stop Old App If Running') {
            steps {
                sh '''
                    if [ -f flask.pid ]; then
                        echo "[INFO] Stopping old Flask app..."
                        kill -9 $(cat flask.pid) || true
                        rm flask.pid
                    fi
                '''
            }
        }

        stage('Start Flask App in Background') {
            steps {
                sh '''
                    . venv/bin/activate
                    nohup python3 app
