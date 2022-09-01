resource "aws_launch_template" "demo_lt" {
  name          = var.lt_name
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name

  user_data = base64encode(data.template_file.user_data.rendered)

  # iam_instance_profile {
  #   name = "s3full_role_for_ec2"
  # }
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.security_groups
  }
  #   block_device_mappings {
  #     device_name = "/dev/sda1"
  #     ebs {
  #       volume_size = 20
  #     }
  #   }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Prod_Server"
    }
  }
  #   instance_market_options {
  #     market_type = "spot"
  #   }  
}
resource "aws_key_pair" "as_lb_key_pair" {
  key_name   = var.key_pair_name
  public_key = file("${path.module}/id_rsa.pub")
}