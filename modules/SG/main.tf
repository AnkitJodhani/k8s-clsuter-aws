#---------------------------- Master node security group---------------------
resource "aws_security_group" "master" {
  name        = "master-sg-k8s"
  description = "will be applied on master node of kuberntes"

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "etcd server client API"
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = [var.VPC_CIDR]
  }
  ingress {
    description = "weave net pod"
    from_port   = 6783
    to_port     = 6783
    protocol    = "tcp"
    cidr_blocks = [var.VPC_CIDR]
  }
  ingress {
    description = "Kubelet API"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [var.VPC_CIDR]
  }
  ingress {
    description = "kube-scheduler"
    from_port   = 10259
    to_port     = 10259
    protocol    = "tcp"
    cidr_blocks = [var.VPC_CIDR]
  }
  ingress {
    description = "kube-controller-manager"
    from_port   = 10257
    to_port     = 10257
    protocol    = "tcp"
    cidr_blocks = [var.VPC_CIDR]
  }
  ingress {
    description = "API server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # New Cilium-specific rules
  ingress {
    description = "VXLAN overlay networking (Cilium)"
    from_port   = 8472
    to_port     = 8472
    protocol    = "udp"
    cidr_blocks = [var.VPC_CIDR]
  }
  ingress {
    description = "Cilium health checks"
    from_port   = 4240
    to_port     = 4240
    protocol    = "tcp"
    cidr_blocks = [var.VPC_CIDR]
  }
  ingress {
    description = "ICMP for Cilium health checks"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.VPC_CIDR]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "master-sg-k8s"
  }
}

#---------------------------- Worker node security group---------------------
resource "aws_security_group" "worker" {
  name        = "worker-sg-k8s"
  description = "will be applied on worker node of kuberntes"

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "NodePort Services"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = [var.VPC_CIDR]
  }
  ingress {
    description = "weave net pod"
    from_port   = 6783
    to_port     = 6783
    protocol    = "tcp"
    cidr_blocks = [var.VPC_CIDR]
  }
  ingress {
    description = "Kubelet API"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [var.VPC_CIDR]
  }

  # New Cilium-specific rules
  ingress {
    description = "VXLAN overlay networking (Cilium)"
    from_port   = 8472
    to_port     = 8472
    protocol    = "udp"
    cidr_blocks = [var.VPC_CIDR]
  }
  ingress {
    description = "Cilium health checks"
    from_port   = 4240
    to_port     = 4240
    protocol    = "tcp"
    cidr_blocks = [var.VPC_CIDR]
  }
  ingress {
    description = "ICMP for Cilium health checks"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.VPC_CIDR]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "worker-sg-k8s"
  }
}
