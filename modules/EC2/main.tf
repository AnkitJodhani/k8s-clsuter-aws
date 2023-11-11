data "aws_availability_zones" "available_zones" {}

resource "aws_instance" "servers" {
  ami                    = var.AMI
  instance_type          = each.value.cpu
  vpc_security_group_ids = [each.value.sg_id]
  key_name               = var.KEY_NAME
  for_each               = local.data
  availability_zone      = each.value.az
  user_data              = filebase64(each.value.script_file)
  tags = {
    Name = each.value.name
  }
}


