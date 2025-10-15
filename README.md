# 🚀 Azure Event-Driven Data Pipeline

-  This project implements an event-driven data pipeline using Microsoft Azure cloud services and Terraform for IaC (Infrastructure as Code). The entire workflow — from infrastructure provisioning to application deployment  is fully automated using GitHub Actions.

- It was developed as part of a cloud engineering assignment focused on serverless data processing, CI/CD automation, and cloud-native architecture.

# 📘 Project Overview

- The pipeline follows a serverless and event-driven architecture designed to:

- Ingest raw data files uploaded to Azure Storage.

- Trigger an Azure Function automatically when new data arrives.

- Process the data and generate summarized reports.

- Store the processed and report files in dedicated containers.

- This project demonstrates how cloud automation and serverless computing can simplify data workflows without requiring manual intervention or dedicated servers.

# 🧱 Deliverables

- Deliverable 1 – Project Requirements & Objective
- A detailed documentation of:
- Problem statement and use case for the event-driven pipeline.
- Identified Azure services suitable for each stage.
- Expected inputs, outputs, and flow of data between components.
- Non-functional requirements such as scalability, security, and cost optimization.

# 🗎 File: Deliverable_1_Requirements.pdf

- Deliverable 2 – Solution Architecture
- A complete architecture diagram illustrating the flow and interaction between Azure resources:
- Azure Blob Storage: Source and destination for data ingestion.
- Azure Functions (Ingest & Report): Serverless compute to process events.
- Azure Event Grid: Event trigger mechanism for blob creation events.
- Azure Application Insights: Monitoring and logging of functions.
- Azure Service Plan & Resource Group: Logical structure for deployment.

# 🗎 File: Deliverable_2_Architecture.pdf

- The diagram visually represents the end-to-end event flow from upload → function trigger → data processing → report generation.
- Deliverable 3 – Infrastructure & Deployment Automation
- All infrastructure and application deployments are automated through:
- Terraform: Creates Azure resource group, storage account, containers, service plan, and function apps.
- GitHub Actions: Automates CI/CD for both functions using the Azure CLI.
- CI/CD Pipeline Workflow:
- Terraform initializes and applies configuration (infra/main.tf).
- Functions are packaged (build_functions.sh).
- The zip files are automatically deployed to Azure Function Apps using:
- az functionapp deployment source config-zip --name <FunctionName> --resource-group <ResourceGroup> --src <zip_file>


# 🗎 File: Deliverable_3_Code_Implementation.zip

- Deliverable 4 – Documentation & Summary
- A professional summary report covering:
- Project overview, motivation, and tools used.
- Step-by-step explanation of each deliverable.
- Screenshots of successful Terraform provisioning and GitHub Actions run.
- Learnings, challenges faced, and outcomes achieved.

# 🗎 File: Deliverable_4_Report.pdf

# 🏗️ Tech Stack

- Category	Tools & Technologies
- Cloud Platform	Microsoft Azure
- Infrastructure as Code	Terraform
- Serverless Compute	Azure Functions (Python)
- CI/CD Automation	GitHub Actions
- Storage	Azure Blob Storage
- Monitoring	Azure Application Insights
- Programming Language	Python 3.10

# 🔄 CI/CD Workflow Summary

- The pipeline runs automatically when code is pushed to the main branch:

- Checkout Code

- Azure Login (using secrets stored in GitHub)
- Terraform Init & Apply
- Package Azure Functions into ZIPs
- Deploy Functions to Azure
- Confirmation via GitHub Actions Logs
- Each run ensures end-to-end automation — from provisioning infrastructure to updating live Azure Function Apps.

# 🔐 Secrets Used in GitHub Actions

- Secret Name	Description
- AZURE_CREDENTIALS	JSON output from az ad sp create-for-rbac for Azure login
- AZURE_RESOURCE_GROUP	Target Resource Group name
- AZURE_FUNCTIONAPP_NAME_INGEST	Function App name for ingest function
- AZURE_FUNCTIONAPP_NAME_REPORT	Function App name for report function

  
# 🧠 Learnings & Key Takeaways

- Gained hands-on experience in event-driven design using Azure Functions and Storage Events.
- Understood how to manage cloud resources using Terraform efficiently.
- Learned how to implement CI/CD automation using GitHub Actions for cloud deployments.
- Overcame real-world challenges like Terraform resource conflicts, naming restrictions, and deployment errors.
- This project strengthened my understanding of cloud automation, IaC, and DevOps workflows on Azure.

# 📫 Author

- Rajeswara Rao
- 💼 B.Tech CSE, Lovely Professional University (2026)
