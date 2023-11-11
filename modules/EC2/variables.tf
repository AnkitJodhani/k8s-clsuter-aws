variable "CPU_MASTER" {}
variable "CPU_WORKER" {}
variable "AMI" {}
variable "MASTER_SG_ID" {}
variable "WORKER_SG_ID" {}
variable "KEY_NAME" {
  default = "control-machine"
}

locals {
  data = {
    master = {
      name   = "master"
      cpu =   var.CPU_MASTER
      sg_id = var.MASTER_SG_ID
      script_file = "../modules/EC2/config_master.sh"
      az = data.aws_availability_zones.available_zones.names[1]
    }
    worker-1 = {
      name   = "worker-1"
      cpu =   var.CPU_WORKER
      sg_id = var.WORKER_SG_ID
      script_file = "../modules/EC2/config_worker-1.sh"
      az = data.aws_availability_zones.available_zones.names[2]
    }
    worker-2 = {
      name   = "worker-2"
      cpu =   var.CPU_WORKER
      sg_id = var.WORKER_SG_ID
      script_file = "../modules/EC2/config_worker-2.sh"
      az = data.aws_availability_zones.available_zones.names[3]
    }
  }
}

