module "nginx-machine" {
  source             = "../my-module"
  node_name          = var.node1
  sg_name            = var.node1-sg-name
  ingress_port_1     = var.node1-port-1 //from 22
  ingress_port_2     = var.node1-port-2 //to 80
  ingress_port_3     = var.node1-port-3 //to 8080
  ingress_port_4     = var.node1-port-4 //to 443
  nginx_private_cidr_1 = ["0.0.0.0/0"]
  nginx_private_cidr_2 = ["0.0.0.0/0"]
  nginx_private_cidr_3 = ["0.0.0.0/0"]
  nginx_private_cidr_4 = ["0.0.0.0/0"]
}
module "python-machine" {
  source             = "../my-module"
  node_name          = var.node2
  sg_name            = var.node2-sg-name
  ingress_port_1     = var.node2-port-1 //from 22
  ingress_port_2     = var.node2-port-2 //to 65432
  ingress_port_3     = var.node2-port-3 //to 8080
  ingress_port_4     = var.node2-port-4 //to 443
  nginx_private_cidr_1 = ["10.0.1.0/24"]
  nginx_private_cidr_2 = ["10.0.1.0/24"]
  nginx_private_cidr_3 = ["10.0.1.0/24"]
  nginx_private_cidr_4 = ["10.0.1.0/24"]
}

module "python-machine2" {
  source             = "../my-module"
  node_name          = var.node3
  sg_name            = var.node3-sg-name
  ingress_port_1     = var.node3-port-1 //from 22
  ingress_port_2     = var.node3-port-2 //to 65432
  ingress_port_3     = var.node3-port-3 //to 8080
  ingress_port_4     = var.node3-port-4 //to 443
  nginx_private_cidr_1 = ["10.0.1.0/24"]
  nginx_private_cidr_2 = ["10.0.1.0/24"]
  nginx_private_cidr_3 = ["10.0.1.0/24"]
  nginx_private_cidr_4 = ["10.0.1.0/24"]
}

output "nginx_machine_public_dns" {
  value = module.nginx-machine.public_dns
}

output "python_machine_public_dns" {
  value = module.python-machine.public_dns
}

output "python_machine_public_dns_2" {
  value = module.python-machine2.public_dns
}

