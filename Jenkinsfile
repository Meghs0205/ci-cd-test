pipeline {
    agent any

    environment {
        VENV = "venv"
        PORT = "5000"
    }

    stages {
        stage('Install Python & Flask') {
            steps {
                sh '''
                    echo "[INFO] Setting up virtual environment..."
                    python3 -m venv ${VENV}
                    . ${VENV}/bin/activate
                    pip install --upgrade pip
                    pip install flask
                '''
            }
        }

        stage('Kill Old Flask App (if running)') {
            steps {
                sh '''
                    echo "[INFO] Checking and stopping any running Flask app..."
                    if [ -f flask.pid ]; then
                        kill -9 $(cat flask.pid) || true
                        rm flask.pid
                    fi
                '''
            }
        }

        stage('Run Flask App in Background') {
            steps {
                sh '''
                    echo "[INFO] Launching Flask app on 0.0.0.0:${PORT}..."
                    . ${VENV}/bin/activate
                    nohup python3 app.py > flask.log 2>&1 &
                    echo $
