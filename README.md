SimpleTimeService Deployment: Docker & AWS EKS
This repository contains the SimpleTimeService application and Terraform configurations for deploying it using Docker and AWS EKS.

Task 1 - Minimalist Application Development / Docker / Kubernetes
Application Overview
SimpleTimeService is a simple microservice built using Flask in Python. It returns the current timestamp and the IP address of the user in a JSON format when accessed via the root (/) URL.

Prerequisites for Task 1
Docker Desktop should be running on your machine.

Steps to Run the Application Locally:
Clone the Repository:

bash
Copy
Edit
git clone https://github.com/nikhilnamaji/simpletimeserviceapp.git
cd simpletimeserviceapp
Build the Docker Image:

bash
Copy
Edit
docker build -t simpletimeservice .
Run the Docker Container:

bash
Copy
Edit
docker run -p 5000:5000 simpletimeservice
Access the Application: Open your browser and navigate to:

arduino
Copy
Edit
http://localhost:5000
You will see a JSON response like:

json
Copy
Edit
{
  "timestamp": "<current date and time>",
  "ip": "<visitor IP>"
}
Task 2 - Terraform Infrastructure Deployment (AWS EKS)
Application Deployment on AWS using Terraform and EKS
In Task 2, we create the necessary infrastructure to deploy SimpleTimeService on AWS using EKS.

Prerequisites for Task 2
AWS Account: Ensure you have an AWS account and the necessary permissions to create resources.

IAM User: You must have an IAM user with the required permissions and note down your IAM User ARN and IAM Username.

AWS CLI: Install and configure the AWS CLI using aws configure.

Terraform: Ensure that Terraform is installed on your system.

Infrastructure Details:
VPC: A VPC with 2 public and 2 private subnets.

EKS Cluster: An EKS cluster deployed in the VPC.

Load Balancer: A load balancer deployed in the public subnets.

Application Deployment: The SimpleTimeService container is deployed on EKS in the private subnets.

Steps to Deploy the Infrastructure:
Clone the Repository:

bash
Copy
Edit
git clone https://github.com/nikhilnamaji/simpletimeserviceapp.git
cd simpletimeserviceapp/Infra
AWS CLI Configuration: Run aws configure and provide your AWS credentials.

Initialize Terraform:

bash
Copy
Edit
terraform init
Validate Terraform Configuration:

bash
Copy
Edit
terraform validate
Terraform Plan:

bash
Copy
Edit
terraform plan
Terraform Apply:

bash
Copy
Edit
terraform apply
Get the Public URL of the Service: After the infrastructure is deployed, run the following command to get the external URL of the service:

bash
Copy
Edit
kubectl get svc
The output will look like:

bash
Copy
Edit
NAME                        TYPE           CLUSTER-IP      EXTERNAL-IP
simpletimeservice-service   LoadBalancer   172.20.29.231   ae925cacef860493a9b5edd68192e26f-995287062.us-east-1.elb.amazonaws.com
Access the Application: Copy the EXTERNAL-IP from the output and access the application in your browser:

arduino
Copy
Edit
http://ae925cacef860493a9b5edd68192e26f-995287062.us-east-1.elb.amazonaws.com/
You will see a JSON response like:

json
Copy
Edit
{
  "timestamp": "<current date and time>",
  "ip": "<visitor IP>"
}
Conclusion
By completing both tasks, you have successfully:

Developed and dockerized the SimpleTimeService microservice.

Created the infrastructure on AWS using Terraform and EKS.

Deployed the containerized application on AWS, making it accessible via a public URL.
