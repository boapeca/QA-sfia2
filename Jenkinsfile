pipeline{
        agent any
        environment {
            app_version = 'v1'
            rollback = 'false'
        }
        stages{
            /*stage('test'){
                steps{
                    sh '''
                    #!/bin/bash
                    cd frontend/
                    pip install -r requirements.txt
                    '''
                }          
            }
            */
            stage('Deploy App'){
                steps{
                    withCredentials([string(credentialsID: 'db_password', variable: 'dbpw')])
                    sh "export DB_PASSWORD=${env.dbpw}
                    sh "export DATABASE_URI=${env.DATABASE_URI}"
                    sh "docker-compose up -d --build"
                }
            }
        }    
}
