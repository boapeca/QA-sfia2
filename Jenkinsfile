pipeline{
        agent any
        environment {
            app_version = 'v1'
            rollback = 'false'
        }
        stages{
            stage('test'){
                steps{
                    sh '''
                    #!/bin/bash
                    cd frontend/
                    pip install -r requirements.txt
                    '''
                }          
            }
            stage('Deploy App'){
                steps{
                    sh "docker-compose up -d --build"
                }
            }
        }    
}
