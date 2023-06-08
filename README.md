# Installing ECK with Terraform on GCP free tier account

On this page you will find a how to spin up ECK using terraform. The main idea is to have a Kubernetes cluster and ECK installed by running only 2 commands.

## Features
_Every feature will be deployed via terraform_

- Deploy GKE (Google Kubernetes Enginee) cluster 
- It will contain 1 node pool with 3 nodes (One in each zone) running on region **europe-west3**
- It contains a helm provider that will be responsible to install the ECK operator
- Elasticsearch cluster with 3 nodes
- 2 Kibana instances with Load balancer
- Hearbeat instance to ingest data in ECK

## Requirements
Before starting you should have the following commands installed:

- [terraform](https://www.terraform.io/downloads)
- [gcloud](https://cloud.google.com/sdk/docs/install)

You also have to create a [Google Cloud Free Tier account](https://cloud.google.com/free).

## TL; DR I want a cluster right now
Once you have implemented the above requirments, authenticate into Google Cloud console:

`gcloud auth application-default login`

Then run the script to create the ECK on GKE cluster and enter input when prompted

`./setup.sh`

## Detailed explanation of the scripts
As you probably know, terraform is an infrastructure as code tool, which means we can describe our infrastructure desire into a file and apply it via terraform.
Here, we are going to spin up a GKE cluster with 3 nodes running on "europe-west3" region (can be changed in `variables.tf`), the machines we are going to use is **e2-standard-2** which will give us 2 vCPU and 8GB of memory in each node with a 50GB data disk for each elastic search node (google cloud free tier limitations as of 12/05/2023)

First, authenticate into Google Cloud console by running the following command:

`gcloud auth application-default login`

Now, you can run

`terraform init`

It will load the providers and configuration. Right after that, you should run

`terraform plan`

It will show you everything that will be created by terraform, take a moment to check this output.
You may see the need to edit certain values set in `main.tf` to adjust for your needs.

Once you are ready, you need to run:

`./setup.sh`

This script will:

- initialize the terraform config directory
- ask you for the google cloud project name, k8s cluster name and google cloud account user/email you plan to use to set up the cluster
- set up the `KUBE_CONFIG_PATH` and `GOOGLE_PROJECT` environment vars
- run the terraform code to create you GKE and ECK clusters
- store the newly created K8s cluster credentials in `~/.kube/config`
- print out the K8s services deployed
- print out the password of the `elastic` ECK cluster user 


You can access your Kibana service by using the LoadBalancer external IP 

## Cleaning up
Set the below environment variables required by terraform:

`export KUBE_CONFIG_PATH="~/.kube/config" && export GOOGLE_PROJECT="<YOUR_PROJECT_ID>"`

 Destroy the ECK cluster and free up GCP account resources:

`terraform destroy`

