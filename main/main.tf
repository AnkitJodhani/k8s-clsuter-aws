
module "VPC" {
    source = "../modules/SG"
    VPC_CIDR = var.VPC_CIDR
}

module "EC2" {
  source = "../modules/EC2"
  CPU_MASTER = var.CPU_master
  CPU_WORKER = var.CPU_worker
  AMI = var.AMI
  MASTER_SG_ID = module.VPC.MASTER_SG_ID
  WORKER_SG_ID = module.VPC.WORKER_SG_ID


}