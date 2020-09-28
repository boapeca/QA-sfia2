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
                    withCredentials([file(credentialsId: 'vm_key', variable: 'my_key')], string(credentialsId: 'DATABASE_URI', variable: 'uri'), string(credentialsId: 'DB_PASSWORD', variable: 'pw'), string(credentialsId: 'SECRET_KEY', variable: 'key')){
                    sh '''
                  
                    ssh -tt -o StrictHostKeyChecking=no -i $my_key ubuntu@ec2-3-10-23-129.eu-west-2.compute.amazonaws.com << EOF
                    rm -rf sfia2
                    git clone https://github.com/psilva12/sfia2.git
                    cd sfia2
                    export MYSQL_DATABASE=db
                    export MYSQL_ROOT_PASSWORD=$DB_PASSWORD
                    export DATABASE_URI=$DATABASE_URI
                    export SECRET_KEY=$SECRET_KEY
                    sudo -E DATABASE_URI=$uri MYSQL_ROOT_PASSWORD=$pw SECRET_KEY=$key docker-compose up -d --build
                    sudo docker-compose logs
                    ls
                    EOF
                    '''
                         
                    }    
                    
                }
            }
                
            stage('make directory'){
                steps{
                    sh '''
                    rm -rf sfiaTest
                    mkdir sfiaTest && cd $_
                    '''
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

