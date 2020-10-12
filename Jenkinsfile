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
            stage('Build Images'){
                            steps{
                                script{
                                    if (env.rollback == 'false'){
                                        sh '''
                                        sudo docker-compose build
                                        '''
                                    }
                                }
                            }
            }
            stage('Tag & Push Images'){
                            steps{
                                script{
                                    if (env.rollback == 'false'){
                                        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials'){
                                            sh '''
                                            sudo docker-compose push
                                            '''
                                        }
                                    }
                                }
                            }
                        }
            stage('ssh step') {
                steps{
                    withCredentials([file(credentialsId: 'vm_key', variable: 'my_key'),string(credentialsId: 'ConnectDB', variable: 'connect'),string(credentialsId: 'TESTDB_URI', variable: 'testUri'), string(credentialsId: 'DATABASE_URI', variable: 'uri'), string(credentialsId: 'DB_PASSWORD', variable: 'pw'), string(credentialsId: 'SECRET_KEY', variable: 'key')]){
                    sh '''
                  
                    ssh -tt -o StrictHostKeyChecking=no -i $my_key ubuntu@ec2-35-176-194-80.eu-west-2.compute.amazonaws.com << EOF
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
                  
                    ssh -tt -o StrictHostKeyChecking=no -i $my_key ubuntu@ec2-35-176-194-80.eu-west-2.compute.amazonaws.com << EOF
                    
                    rm -rf sfiaTest
                    cd sfia2
                    $connectTest
                    source database/Create.sql;
                    exit
                    sudo docker exec sfia2_frontend_1 pytest --cov application
                    sudo docker exec sfia2_backend_1 pytest --cov application

                    sudo docker exec sfia2_frontend_1 pytest --cov application > frontendTest.txt
                    sudo docker exec sfia2_backend_1 pytest --cov application > backendTest.txt

                    exit
                    >> EOF

                    '''
                    // --cov-report term --cov=sfia2 tests/ 
                    }        
                }          
            }
        }
    
}

