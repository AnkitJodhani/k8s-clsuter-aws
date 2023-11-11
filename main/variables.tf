variable "REGION" {
  default = "us-east-1"
}
variable "PROJECT_NAME" {
  default = "kubeadm-k8s-2-node"
}
variable "CPU_master" {
  default = "t2.medium"
}
variable "CPU_worker" {
  default = "t2.large"
}
variable "VPC_CIDR" {
  default = "172.31.0.0/16"
}
variable "AMI" {
  default = "ami-0fc5d935ebf8bc3bc"
}
