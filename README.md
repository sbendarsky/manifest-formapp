# FormApp - DevOps Portfolio (Manifest Repository)
This DevOps portfolio serves as a comprehensive demonstration of our academic journey, showcasing a variety of methodologies and skills that we've learnt during our studies.

[![CI / CD](https://github.com/sbendarsky/formapp-portfolio/actions/workflows/cicd.yml/badge.svg)](https://github.com/sbendarsky/formapp-portfolio/actions/workflows/cicd.yml)

## Infrastructe Repository
This repository contains the code for provisioning the infrastructure required to run the application found in this repository.

The infrastructure comprises an EKS cluster with Kubernetes setup.
![ArgoCD Dashboard](https://github.com/sbendarsky/formapp-portfolio/blob/main/resources/diagram-terraform.png)

Kubernetes infrastructure is managed using Helm charts stored in this repository.

To build the infrastructure, execute the route53.sh script within the terraform directory. Before running the script, update the production.tfvars file with the necessary variables. Also, customize the script with your own hosted zone and domain.

## Requirments
To run the code in this repository, you will need to do the following:

1. Configure your AWS CLI with the necessary permissions to provision the infrastructure.
2. Customize the route53.sh script with your domain and hosted zone.

## Additional Information
The application's source code resides in a separate repository, facilitating efficient control. CI/CD processes start and end there, modifying the values.yaml within the Helm chart, which is tracked and synced by ArgoCD as needed.
Make sure to checkout the [formapp-portfolio](https://github.com/sbendarsky/formapp-portfolio) repository.
