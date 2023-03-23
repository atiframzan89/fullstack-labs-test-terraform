
# EC2 Related Output

output "node-app-ec2-public-ip" {
  value = module.ec2.node-app-public-ip
}

# output "node-app-ec2-private-ip" {
#     value = module.ec2.node-app-ec2-private-ip
# }