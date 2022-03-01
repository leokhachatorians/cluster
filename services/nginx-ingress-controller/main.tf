terraform {
  backend "gcs" {
    bucket      = "tf-state-bucket-leo"
    prefix      = "nginx"
    credentials = "../../config/tf-gke-cluster-key.json"
  }

  required_providers {
    kubernetes = {
      version = "2.7.1"
    }
    helm = {
      version = "2.4.1"
    }
  }
}

locals {
  const     = yamldecode(file("${path.module}/../../config/const.yaml"))
  namespace = "nginx"
}

provider "kubernetes" {
  config_path = local.const.config_path

}

provider "helm" {
  kubernetes {
    config_path = local.const.config_path
  }
}

resource "kubernetes_namespace" "nginx" {
  metadata {
    name = local.namespace
  }
}

resource "helm_release" "nginx-ingress" {
  name       = "nginx"
  namespace  = local.namespace
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"
  version    = "0.12.1"
}
