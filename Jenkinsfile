pipeline {
    agent any
    stages {
        stage('Setup Python') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install flask
                '''
            }
        }
        stage('Kill Old Flask') {
            steps {
                sh '''
                    pkill -f 'python3 app.py' || true
                '''
            }
        }
        stage('Run Flask App') {
            steps {
                sh '''
                    . venv/bin/activate
                    # Use setsid to detach fully
                    setsid python3 app.py > flask.log 2>&1 < /dev/null &
                '''
            }
        }
    }
}
