pipeline{
        agent any
        environment {
            app_version = 'v1'
            rollback = 'false'
            SECRET_KEY = credentials("SECRET_KEY")
            DB_PASSWORD = credentials("DB_PASSWORD")
            DATABASE_URI = credentials("DATABASE_URI")   
                
        }
        stages{
            stage('ssh step') {
                steps{
                    withCredentials([file(credentialsId: 'vm_key', variable: 'my_key'),string(credentialsId: 'ConnectDB', variable: 'connect'),string(credentialsId: 'TESTDB_URI', variable: 'testUri'), string(credentialsId: 'DATABASE_URI', variable: 'uri'), string(credentialsId: 'DB_PASSWORD', variable: 'pw'), string(credentialsId: 'SECRET_KEY', variable: 'key')]){
                    sh '''
                  
                    ssh -tt -o StrictHostKeyChecking=no -i $my_key ubuntu@ec2-18-130-229-61.eu-west-2.compute.amazonaws.com << EOF
                    sudo service nginx stop
                    rm -rf sfia2
                    git clone https://github.com/psilva12/sfia2.git
                    cd sfia2
                    $connect
                    source database/Create.sql;
                    exit
                    sudo -E MYSQL_ROOT_PASSWORD=$pw DB_PASSWORD=$pw TEST_DATABASE_URI=$testUri DATABASE_URI=$uri SECRET_KEY=$key docker-compose up -d --build
                    sudo docker-compose logs
                    ls
                    exit
                    >> EOF
                    '''
                         
                            
                    }    
                    
                }
            }
                
            stage('Testing'){
                steps{
                    withCredentials([file(credentialsId: 'vm_key', variable: 'my_key'),string(credentialsId: 'TESTDB_CONNECT', variable: 'connectTest'),string(credentialsId: 'TESTDB_URI', variable: 'testUri'), string(credentialsId: 'DB_PASSWORD', variable: 'pw'), string(credentialsId: 'SECRET_KEY', variable: 'key')]){
                    sh '''
                  
                    ssh -tt -o StrictHostKeyChecking=no -i $my_key ubuntu@ec2-18-130-229-61.eu-west-2.compute.amazonaws.com << EOF    
                    
                    rm -rf sfiaTest
                    cd sfia2
                    $connectTest
                    source database/Create.sql;
                    exit
                    sudo docker exec -it sfia2_backend_1 pytest --cov application --cov-report term --cov=sfia2 tests/
                    sudo docker exec -it sfia2_frontend_1 pytest --cov application --cov-report term --cov=sfia2 tests/ 
                    exit
                    >> EOF
                    '''
                    }        
                }          
            }
            /*
            stage('Install Docker & Docker-compose'){
                steps{
                        
                        curl https://get.docker.com | sudo bash
                    sudo usermod -aG docker $(whoami)
                        
                    sh '''
                    curl https://get.docker.com | sudo bash
                    sudo usermod -aG docker $(whoami)
                    sudo systemctl enable docker
                    sudo curl -L "https://github.com/docker/compose/releases/download/1.27.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                    sudo chmod +x /usr/local/bin/docker-compose
                    '''
                        
                }
            }
            stage('Deploy App'){
                steps{
                    //sh "sudo docker-compose down --rmi all"
                    sh "export MYSQL_DATABASE=db"          
                    sh "export MYSQL_ROOT_PASSWORD=$DB_PASSWORD"
                    sh "export DATABASE_URI=$DATABASE_URI"
                    // sh "source ./load_env.sh"
                    sh "export SECRET_KEY=$SECRET_KEY"
                    // sh "sudo docker-compose up -d --build backend=${DB_PASSWORD} backend=${DATABASE_URI} backend=${SECRET_KEY}"
                    sh "sudo -E DATABASE_URI=$DATABASE_URI MYSQL_ROOT_PASSWORD=$DB_PASSWORD SECRET_KEY=$SECRET_KEY docker-compose up -d --build"
                    //sudo -E MYSQL_ROOT_PASSWORD=${DB_PASSWORD} DB_PASSWORD=${DB_PASSWORD} DATABASE_URI=${DATABASE_URI} SECRET_KEY=${SECRET_KEY} docker-compose pull && sudo -E MYSQL_ROOT_PASSWORD=${DB_PASSWORD} DB_PASSWORD=${DB_PASSWORD} DATABASE_URI=${DATABASE_URI} SECRET_KEY=${SECRET_KEY} docker-compose up -d --build
                    // sh "mysql_upgrade --protocol=tcp -P 3306"
                    sh "sudo docker-compose logs"
                }
            }
*/
                
        }
    
}

