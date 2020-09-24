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

                    sh "export DB_PASSWORD=credentials('DB_PASSWORD')
                    sh "export DATABASE_URI=credentials('DATABASE_URI')
                    sh "export SECRET_KEY=credentials('SECRET_KEY')
                    sh "docker-compose up -d --build"
                }
            }
        }    
}
