# QAC SFIA2 Project

This application is a simple [Flask application](https://flask.palletsprojects.com/en/1.1.x/quickstart/#a-minimal-application), ready to be deployed, for your SFIA2 project.

The following information should be everything you need to complete the project.

## Brief

The purpose of this Sfia2 Project was to deploy a simple python application through a continuous integration pipeline using various tools. 

### Requirements
The requirements for this project are listed as follows:

- Kanban Board: Jira
- Version Control: Git
- CI Server: Jenkins
- Configuration Management: Ansible
- Cloud Server: AWS EC2
- Database Server: AWS RDS
- Containerisation: Docker
- Reverse Proxy: NGINX
- Orchestration Tool: Kubernetes
- Infrastructure Management: Terraform

### Implementation

## Jira Board

Jira was used as a Kanban Board to plan user stories and tasks that needed to be completed in order check the progress of development.
Each tasks was assigned to their respective parent in order to keep better track if any major technology was either failing or falling behind in the implementation process.
![jira-board](https://github.com/psilva12/sfia2/blob/master/images/jiraBoard.png)

### CI Pipeline / MVP
![mvp-diagram](https://i.imgur.com/i5qfOas.png)

### Risk Assessment
![Risk-Assessment](https://github.com/psilva12/sfia2/blob/master/images/RiskAssessment.png)


### Technologies Used

#### Version Control

For version control GitHub was used once again. Github allows for different branches to be present on the project and therefore allowing a stable version to be deployed to the end user. By having multiple commits Git also allowed for "save points" that could be reverted to in case the project would break, therefore reverting to a stable version.

#### Docker and Docker Compose

Both Docker and Docker compose are tools used for containerisation, these technology is particularly useful to deploy an application to different environments as only Docker and Docker compose would be needed to be installed to run the application.
Docker and docker compose are also respondible for installing any dependencies that the application might require to run itself. Docker also provides a feature that allows for images to be pushed to Docker hub and then pulled from it to build and application with even more ease and always have the most up to date image version.

#### AWS EC2 & RDS

AWS was the cloud provider used for this sfia2 project. AWS was used to create 2 EC2 instance as well as 2 RDS instances to be used for this project.

#### Jenkins

For the CI of this project the tool used was Jenkins. Jenkins was set with a webhook to the projects github which meant every commit made to the appropriate branch it would trigger the Jenkins pipeline set in place.

#### Ansible & Terraform

Ansible and Terraform were used as the Configuration Management and Infrastructure Management tools, respectively. 
Terraform was responsible to create resources in AWS, in this case create 2 EC2 instances and configure the rules needed for the instances as well as 2 RDS instances to be used as databases for the project.
Ansible was responsible to install and configure the VM's with their dependencies, it was mainly used to install Jenkins in one VM and docker and docker compose in another to be able to run all tests and deployment more efficiently.

#### Nginx

Nginx was used as a reverse proxy, meaning the application would be behind nginx and could only be accessible through port 80 and not directly on the applications' frontend. Nginx provides, therefore extra security by not allowing the end user to directly interact with the frontend itself.

#### Kubernetes

Kubernetes was the Orchestration Tool used for this project. Kubernetes is a super powerful tool that can deploy multiple instances of the same application if needed, is easily scalable and easy to deploy, update and take down with a few commands.
Kubernetes pulls the images from my Docker Hub in order create the live environment for the project.


### Author

- Paulo Silva