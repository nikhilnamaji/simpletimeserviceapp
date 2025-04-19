📄 SimpleTimeServiceApp
A minimalist microservice and infrastructure deployment project.

This repository includes:

Task 1: A simple Python + Flask microservice called SimpleTimeService, containerized using Docker.

Task 2: AWS infrastructure provisioning using Terraform to deploy the container on an Amazon EKS cluster with an external Load Balancer.

✅ Task 1 — SimpleTimeService Application
📌 Description:
A lightweight web server that returns a JSON response with the current timestamp and the visitor's IP address when accessed at the / route.

Example JSON Response

json
Copy
Edit
{
  "timestamp": "2025-04-19 14:30:55",
  "ip": "123.45.67.89"
}
📌 Dockerized Application:
Built using Python 3.12-slim base image.

Runs securely as a non-root user inside the container.

Exposes port 5000 inside the container.

📌 To Run Locally:
Make sure Docker Desktop is running before executing:

bash
Copy
Edit
docker build -t simpletimeservice .
docker run -d -p 5000:5000 simpletimeservice
Now open your browser and go to:

arduino
Copy
Edit
http://localhost:5000


✅ Task 2 — AWS EKS Infrastructure with Terraform
📌 Infrastructure Overview:
VPC with 2 public and 2 private subnets.

Amazon EKS Cluster deployed inside the VPC.

Kubernetes Deployment running the SimpleTimeService container.

Kubernetes Service of type LoadBalancer.

AWS Application Load Balancer (ALB) exposing the service publicly.

📌 Application URL (while live):
arduino
Copy
Edit
http://ae925cacef860493a9b5edd68192e26f-995287062.us-east-1.elb.amazonaws.com/
(The infrastructure has now been destroyed to avoid AWS charges. It can be redeployed using the Terraform code in this repo.)

📌 Ports:
Container runs on: 5000


📌 Prerequisites:
AWS CLI installed and configured using aws configure

Docker installed and running

Terraform installed

Note down your IAM User ARN and IAM Username
(Terraform will prompt for these during terraform init)

📌 Deployment Steps:
bash
Copy
Edit
terraform init
# Enter your IAM User ARN and Username when prompted

terraform validate
terraform plan
terraform apply
📌 Verification:
After successful deployment:

bash
Copy
Edit
kubectl get nodes
kubectl get svc
Note the EXTERNAL-IP of the LoadBalancer service.

Open it in your browser to see the JSON response.


