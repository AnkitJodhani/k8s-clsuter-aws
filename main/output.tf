# Use the local_file resource to write the IPs to ip.txt
resource "local_file" "ip_list" {
  content = <<EOF
Master_node_ip: ${module.EC2.master_node_ip}
Worker_node_1_ip: ${module.EC2.worker_node_1_ip}
Worker_node_2_ip: ${module.EC2.worker_node_2_ip}
EOF

  filename = "${path.module}/ip.txt"
}

