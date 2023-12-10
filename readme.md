# DevOps Challenge

## Overview

This project builds a serverless API using AWS AppSync that interacts with a PostgreSQL database managed by Amazon RDS. The infrastructure is defined and provisioned using Terraform, organized into modular components for better maintainability. It has also a CI/CD configured using Github actions.

## Components

### VPC Module (`modules/vpc`)

- Created a Virtual Private Cloud (VPC) in AWS with public and private subnets.
- Defined routing tables, Internet Gateway, and Network Address Translation (NAT) Gateway for connectivity.
- Outputs the IDs of public and private subnets.

### RDS Module (`modules/rds`)

- Setted up an Amazon RDS PostgreSQL instance for storing data.
- Configured a security group to control incoming traffic to the database.
- Specified a subnet group to place the RDS instance in the desired subnets.
- Outputs the endpoint of the RDS instance.

### AppSync Module (`modules/appsync`)

- Created an AWS AppSync API to serve as the serverless GraphQL API.
- Defined a data source connected to the RDS PostgreSQL instance.
- Setted up a GraphQL schema for data operations
- Outputs the AppSync API URL.

## CI/CD Pipeline

The project includes a GitHub Actions workflow for CI/CD. The workflow is triggered on pushes to the `main` branch.

### Workflow Steps

1. **Checkout Repository:**
   - Fetches the content of the repository and checks it out to the runner's workspace.

2. **Set up Terraform:**
   - Sets up Terraform in the GitHub Actions runner environment.

3. **Initialize Terraform:**
   - Initializes Terraform in the GitHub Actions runner environment.

4. **Validate Terraform:**
   - Validates the Terraform configuration for syntax and other errors.

5. **Plan:**
   - Generates an execution plan for Terraform changes.

6. **Apply (On Push to `main`):**
   - Applies Terraform changes automatically when a push event occurs on the `main` branch.

## Deployment Steps

1. **Initialize Terraform:**
   - Run `terraform init` in the project directory to initialize Terraform.

2. **Deploy VPC:**
   - Change to the VPC module directory (`modules/vpc`).
   - Run `terraform apply` to create the VPC and subnets.
   - Note the subnet IDs from the output.

3. **Deploy RDS:**
   - Change back to the project root directory.
   - Run `terraform apply` to create the RDS instance using the subnet IDs obtained from the VPC output.
   - Note the RDS instance endpoint from the output.

4. **Deploy AppSync:**
   - Run `terraform apply` to create the AppSync API and connect it to the RDS instance.
   - Note the AppSync API endpoint from the output.

5. **Access Resources:**
   - Access the AppSync API using the provided endpoint URL.
   - Connect to the RDS database using the provided endpoint.
