# WebAppSuite DevOps Project

## Project Overview

This project demonstrates a complete DevOps lifecycle for a multi-tier Java web application called WebAppSuite. The project includes infrastructure as code, configuration management, continuous integration, continuous deployment, containerization, and orchestration.

## Architecture

The architecture consists of the following components:

*   **AWS:** The cloud platform used to host the infrastructure.
*   **Terraform:** Used to provision the infrastructure on AWS.
*   **Ansible:** Used to configure the application servers.
*   **Jenkins:** Used for continuous integration and continuous deployment.
*   **Docker:** Used to containerize the application.
*   **Kubernetes (EKS):** Used to orchestrate the containerized application.
*   **Prometheus & Grafana:** Used for monitoring and logging.

Here is a diagram of the architecture:

![Architecture Diagram](architecture.png)  <!-- I will create this diagram later -->

## Prerequisites

To run this project, you will need the following:

*   An AWS account.
*   Terraform installed.
*   Ansible installed.
*   Jenkins installed.
*   Docker installed.
*   kubectl installed.

## How to Run

1.  **Clone the repository:**

    ```
    git clone https://github.com/vibecoe/projects.git
    cd vprofile-project
    ```

2.  **Provision the infrastructure:**

    ```
    cd terraform
    terraform init
    terraform apply
    ```

3.  **Configure the application servers:**

    The Terraform output will generate an Ansible inventory file. Use this inventory file to run the Ansible playbook.

    ```
    cd ../ansible
    ansible-playbook -i inventory playbook.yml
    ```

4.  **Set up the Jenkins pipeline:**

    *   Create a new pipeline in Jenkins.
    *   Point the pipeline to the `jenkins/Jenkinsfile` in this repository.
    *   Run the pipeline.

5.  **Deploy to Kubernetes:**

    The Jenkins pipeline will deploy the application to the Kubernetes cluster.

## Technologies Used

*   **Cloud:** AWS
*   **IaC:** Terraform
*   **Configuration Management:** Ansible
*   **CI/CD:** Jenkins
*   **Containerization:** Docker
*   **Orchestration:** Kubernetes (EKS)
*   **Monitoring:** Prometheus & Grafana
*   **Application:** Java, Spring, Maven
