resource "aws_instance" "app_node" {
    ami  = "ami-0b4c7755cdf0d9219"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.projectsg.id]
    subnet_id     = aws_subnet.main_subnet.id
    key_name = "jonag"

    tags = {
        Name  = var.node_name
    }
  
}

output "public_dns" {
    value       = aws_instance.app_node.public_dns
}

output "private_ip" {
    value       = aws_instance.app_node.private_ip
}