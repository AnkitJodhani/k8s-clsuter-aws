terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "learning-terraform"
    key            = "backend/kubeadm-k8s-2-node.tfstate"
    dynamodb_table = "dynamoDB-state-locking"
  }
}