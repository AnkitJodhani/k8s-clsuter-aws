output "MASTER_SG_ID" {
    value = aws_security_group.master.id
}
output "WORKER_SG_ID" {
    value = aws_security_group.worker.id
}