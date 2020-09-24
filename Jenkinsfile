pipeline{
        agent any
        environment {
            app_version = 'v1'
            rollback = 'false'
        }
        stages{
            stage('make directory'){
                steps{
                    sh '''
                    rm -rf sfiaTest
                    mkdir sfiaTest && cd $_
                    '''
                }          
            }
            
            stage('Install Docker & Docker-compose'){
                steps{
                    sh '''
                    curl https://get.docker.com | sudo bash
                    sudo curl -L "https://github.com/docker/compose/releases/download/1.27.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                    sudo chmod +x /usr/local/bin/docker-compose
                    '''
                        
                }
            }
            stage('Deploy App'){
                steps{
                    sh "export MYSQL_DATABASE=db"
                    
                    sh "export MYSQL_ROOT_PASSWORD"
                    sh "export DATABASE_URI"
                    sh "export SECRET_KEY"
                   
                    sh "sudo -E MYSQL_ROOT_PASSWORD=${DB_PASSWORD} DATABASE_URI=${DATABASE_URI} SECRET_KEY=${SECRET_KEY} docker-compose up -d --build"
                    sh "sudo docker-compose logs"    
                }
            }
        }    
}
