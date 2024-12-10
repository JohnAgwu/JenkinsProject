resource "aws_security_group" "projectsg" {
  name = var.sg_name
  vpc_id = aws_vpc.main.id
  egress  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress  {
    from_port = var.ingress_port_1
    to_port = var.ingress_port_1
    protocol = "tcp"
    cidr_blocks = [var.nginx_private_cidr_1]
    ipv6_cidr_blocks = ["::/0"]
  }
    ingress  {
    from_port = var.ingress_port_2
    to_port = var.ingress_port_2
    protocol = "tcp"
    cidr_blocks = [var.nginx_private_cidr_2]
    # ipv6_cidr_blocks = ["::/0"]
  }

  ingress  {
    from_port = var.ingress_port_3
    to_port = var.ingress_port_3
    protocol = "tcp"
    cidr_blocks = [var.nginx_private_cidr_3]
    # ipv6_cidr_blocks = ["::/0"]
  }

  ingress  {
    from_port = var.ingress_port_4
    to_port = var.ingress_port_4
    protocol = "tcp"
    cidr_blocks = [var.nginx_private_cidr_4]
    # ipv6_cidr_blocks = ["::/0"]
  }

}