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
            stage('Testing'){
                steps{
                    withCredentials([file(credentialsId: 'vm_key', variable: 'my_key'),string(credentialsId: 'TESTDB_CONNECT', variable: 'connectTest'),string(credentialsId: 'TESTDB_URI', variable: 'testUri'), string(credentialsId: 'DB_PASSWORD', variable: 'pw'), string(credentialsId: 'SECRET_KEY', variable: 'key')]){
                    sh '''

                    ssh -tt -o StrictHostKeyChecking=no -i $my_key ubuntu@ec2-35-178-177-197.eu-west-2.compute.amazonaws.com << EOF

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


                    '''
                    // --cov-report term --cov=sfia2 tests/
                    }
                }
            }
            stage('Deploy') {
                steps{
                    withCredentials([file(credentialsId: 'vm_key', variable: 'my_key'),file(credentialsId: 'kubeBackend', variable: 'backendYaml'),string(credentialsId: 'backendText', variable: 'textBackend'),string(credentialsId: 'ConnectDB', variable: 'connect'),string(credentialsId: 'gcloudLogin', variable: 'loginGcloud'),string(credentialsId: 'TESTDB_URI', variable: 'testUri'), string(credentialsId: 'DATABASE_URI', variable: 'uri'), string(credentialsId: 'DB_PASSWORD', variable: 'pw'), string(credentialsId: 'SECRET_KEY', variable: 'key')]){
                    sh '''

                    ssh -tt -o StrictHostKeyChecking=no -i $my_key ubuntu@ec2-35-176-194-80.eu-west-2.compute.amazonaws.com << EOF
                    sudo service nginx stop

                    rm -rf sfia2
                    git clone https://github.com/psilva12/sfia2.git
                    cd sfia2
                    $connect
                    source database/Create.sql;
                    exit
                    sudo -E MYSQL_ROOT_PASSWORD=$pw DB_PASSWORD=$pw TEST_DATABASE_URI=$testUri DATABASE_URI=$uri SECRET_KEY=$key docker-compose build
                    sudo docker-compose logs
                    $loginGcloud

                    kubectl apply -f $backendYaml
                    kubectl apply -f kubectl/
                    kubectl get services
                    ls
                    exit
                    >> EOF
                    '''


                    }

                }
            }

        }
    
}

