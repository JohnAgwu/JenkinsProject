module "nginx-machine" {
  source         = "../my-module"
  node_name      = var.node1
  sg_name        = var.node1-sg-name
  ingress_port_1 = var.node1-port-1
  ingress_port_2 = var.node1-port-2
}
module "python-machine" {
  source         = "../my-module"
  node_name      = var.node2
  sg_name        = var.node2-sg-name
  ingress_port_1 = var.node2-port-1
  ingress_port_2 = var.node2-port-2
}



output "nginx_machine_public_dns" {
  value = module.nginx-machine.public_dns
}

output "python_machine_public_dns" {
  value = module.python-machine.public_dns
}



