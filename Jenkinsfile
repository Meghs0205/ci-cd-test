pipeline {
    agent any

    environment {
        VENV = "venv"
        EC2_PUBLIC_IP = "54.183.124.173"  // Replace with your actual public IP
    }

    stages {
        stage('Set Up Python Environment') {
            steps {
                sh '''
                    echo "[INFO] Creating virtual environment..."
                    python3 -m venv ${VENV}
                    . ${VENV}/bin/activate
                    pip install --upgrade pip
                    pip install flask
                '''
            }
        }

        stage('Stop Existing Flask App') {
            steps {
                sh '''
                    if [ -f flask.pid ]; then
                        echo "[INFO] Stopping previous Flask app..."
                        kill -9 $(cat flask.pid) || true
                        rm flask.pid
                    else
                        echo "[INFO] No previous flask.pid found."
                    fi
                '''
            }
        }

        stage('Run Flask App') {
            steps {
                sh '''
                    echo "[INFO] Starting Flask app on 0.0.0.0:5000..."
                    . ${VENV}/bin/activate
                    nohup python3 app.py --host=0.0.0.0 --port=5000 > flask.log 2>&1 &
                    echo $! > flask.pid
                '''
            }
        }

        stage('Verify App is Running Publicly') {
            steps {
                sh '''
                    sleep 3
                    echo "[INFO] Checking app via public IP..."
                    curl -s http://${EC2_PUBLIC_IP}:5000 || echo "[WARN] App not responding via public IP"
                '''
            }
        }
    }
}

