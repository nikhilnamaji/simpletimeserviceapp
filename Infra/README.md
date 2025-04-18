# SimpleTimeService Deployment on AWS EKS using Terraform

## 🚀 Overview

This repository contains Terraform code to deploy a simple time service application (SimpleTimeService) on AWS using Elastic Kubernetes Service (EKS). It covers the entire process of setting up the necessary infrastructure (VPC, subnets, IAM roles) and deploying the application to Kubernetes.

## 🛠️ Steps I Followed

### 1. **Setting Up the Infrastructure:**
   - **VPC Creation:** I first created a custom Virtual Private Cloud (VPC) to isolate the network resources for the application.
   - **Subnets:** Configured public and private subnets to ensure the application and its services are properly segmented.
   - **IAM Roles:** Created the necessary IAM roles and policies to give Kubernetes nodes and the EKS service the required permissions.
   - **EKS Cluster:** Set up an EKS cluster using Terraform with the correct node groups and resources to run the application.

### 2. **Deploying the Application:**
   - After setting up the EKS cluster, I created the necessary **Kubernetes deployment** and **service** configurations using YAML files. These files were then applied to the cluster.
   - The service was exposed using a **LoadBalancer** type, making the SimpleTimeService accessible via a public URL.

### 3. **Connecting and Verifying:**
   - Configured **kubectl** to interact with the EKS cluster using AWS credentials and the `aws-auth` config file.
   - After deploying the service, I verified that the SimpleTimeService was running successfully and accessible through the AWS Load Balancer URL.

### 4. **Terraform Configuration:**
   - All infrastructure resources are defined in Terraform files. I used Terraform to manage and deploy the infrastructure, ensuring that the setup can be recreated or destroyed easily.
   - **Important Files:**
     - `1-variables.tf`: Contains variables for customizable configurations (e.g., region, instance types).
     - `2-vpc.tf`: Defines the VPC and networking resources.
     - `3-eks.tf`: Defines the EKS cluster and associated configurations.
     - `outputs.tf`: Displays key output values (e.g., LoadBalancer URL).
   
### 5. **What Worked:**
   - Everything deployed smoothly, and the service was accessible via the public URL. The load balancer correctly routed traffic to the Kubernetes pods running the SimpleTimeService.

### 6. **What Could Be Improved:**
   - One improvement could be automating the deployment pipeline with CI/CD tools like Jenkins or GitHub Actions.
   - Ensuring that all sensitive information is securely handled using environment variables or AWS Secrets Manager.

## 💡 Conclusion

This setup helped me learn how to use AWS EKS with Terraform for deploying containerized applications. It’s a great learning project for anyone looking to understand how Kubernetes can be used to deploy and manage applications in the cloud.

## 🔑 Sensitive Information

Make sure **not** to share sensitive files such as `terraform.tfvars` with your AWS credentials or secrets. Always use environment variables or AWS Secrets Manager for sensitive data.

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
