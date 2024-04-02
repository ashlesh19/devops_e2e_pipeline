# DevOps End-to-End Pipeline Project

## Overview

This project implements a distributed DevOps pipeline utilizing Jenkins, SonarQube, and ArgoCD for continuous integration and continuous deployment (CI/CD). The pipeline automates the process of building, testing, analyzing, and deploying applications, ensuring efficiency and reliability in the software delivery lifecycle across multiple AWS EC2 instances and Kubernetes clusters.

## Features

- **Continuous Integration (CI)**: Jenkins orchestrates the CI process, integrating with Maven for building and testing the application codebase.
- **Static Code Analysis**: SonarQube performs static code analysis to identify code quality issues, bugs, and security vulnerabilities.
- **Continuous Deployment (CD)**: ArgoCD automates the deployment of Docker containers to Kubernetes clusters, ensuring consistent and reliable application delivery.
- **Distributed Architecture**: Jenkins master and agent instances, SonarQube server, and ArgoCD cluster are deployed across separate AWS EC2 instances, optimizing resource utilization and scalability.
- **GitHub Integration**: The project codebase is hosted on GitHub, enabling seamless integration with Jenkins for code checkout and pipeline execution.

## Prerequisites

Before setting up the pipeline, ensure the following prerequisites are met:

- **Jenkins Master and Agent Setup**: Deploy Jenkins master and agent instances on separate AWS EC2 instances. Configure Jenkins master to distribute workload to agent instances.
- **SonarQube Server**: Set up a SonarQube server on a dedicated AWS EC2 instance for code analysis. Obtain the necessary access tokens for integration with Jenkins.
- **ArgoCD Cluster**: Deploy an ArgoCD cluster on a Kubernetes cluster (e.g., k3s) running on AWS EC2 instances for continuous deployment of Docker containers.
- **GitHub Repository**: The application codebase must be hosted on GitHub.

## Setup Instructions

1. **Jenkins Configuration**:
   - Install and configure Jenkins master on one EC2 instance and agent instances on separate EC2 instances.
   - Set up Jenkins plugins for Maven, Docker, and other required integrations.
   - Configure Jenkins master to distribute workload to agent instances.

2. **SonarQube Integration**:
   - Configure Jenkins to integrate with SonarQube, providing access tokens for authentication.

3. **ArgoCD Setup**:
   - Deploy an ArgoCD cluster on Kubernetes (e.g., k3s) running on AWS EC2 instances.
   - Configure ArgoCD for continuous deployment of Docker containers.

4. **Pipeline Setup**:
   - Create a new Jenkins pipeline job and point it to the Jenkinsfile in your project repository.
   - Define environment variables and adjust configuration parameters as per your project requirements.

5. **GitHub Integration**:
   - Configure Jenkins to integrate with your GitHub repository for code checkout.

6. **Run Pipeline**:
   - Trigger the pipeline manually or set up webhooks for automatic triggering on code commits.

## Workflow

1. **Code Checkout**:

- Jenkins fetches the application code from the GitHub repository at the beginning of the pipeline execution.

2. **Build & Test**:

- Maven is utilized to build the application and execute tests to ensure code quality and functionality.

3.**Static Code Analysis**:

- SonarQube performs static code analysis to identify code smells, bugs, and security vulnerabilities.

4.**Quality Gate**:

- The pipeline waits for the SonarQube Quality Gate to pass before proceeding, ensuring that code quality standards are met.

5.**Docker Image Creation**:

- Docker builds an image of the application, tagged with a version number incorporating the Jenkins build number.
- The Docker image is pushed to Docker Hub for centralized distribution.

6.**Continuous Deployment Trigger**:
- Upon successful completion of the pipeline, a separate Jenkins job (devops-manifest-pipeline) is triggered to initiate the continuous deployment process.
- This likely involves deploying the Docker image to a target environment for production or further testing.

## The project repo for **devops-manifest-pipeline** can be found here

```bash
git clone https://github.com/ashlesh19/devops_manifest.git
