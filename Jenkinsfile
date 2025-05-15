pipeline {
    agent any

    environment {
        VENV = "venv"
        PORT = "5000"
    }

    stages {
        stage('Set Up Python & Flask') {
            steps {
                sh '''
                    python3 -m venv ${VENV}
                    . ${VENV}/bin/activate
                    pip install --upgrade pip
                    pip install flask
                '''
            }
        }

        stage('Stop Previous Flask App') {
            steps {
                sh '''
                    if [ -f flask.pid ]; then
                        echo "[INFO] Killing previous Flask process..."
                        kill -9 $(cat flask.pid) || true
                        rm flask.pid
                    fi
