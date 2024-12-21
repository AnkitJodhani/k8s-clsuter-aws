// output.tf

# Define output for Master Node IP
output "master_node_ip" {
  description = "IP address of the Master node"
  value       = aws_instance.servers["master"].public_ip
}

# Define output for Worker Node 1 IP
output "worker_node_1_ip" {
  description = "IP address of Worker node 1"
  value       = aws_instance.servers["worker-1"].public_ip
}

# Define output for Worker Node 2 IP
output "worker_node_2_ip" {
  description = "IP address of Worker node 2"
  value       = aws_instance.servers["worker-2"].public_ip
}

