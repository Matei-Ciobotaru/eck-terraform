locals {
  region = "europe-west3"
}

variable "kubernetes_name" {
  type        = string
  description  = "Please, enter your GKE cluster name"
}

variable "output" {
  description = "GKE connection string"
  type        = string
  default     = "TO CONNECT TO KUBERNETES: gcloud container clusters get-credentials <K8S_CLUSTER_NAME> --region europe-west3 --project <GOOGLE_PROJECT_NAME>"
}

variable "email" {
  type        = string
  description = "Please, enter your email (elastic email) or a user"
}
