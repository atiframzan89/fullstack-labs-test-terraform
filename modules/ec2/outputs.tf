output "node-app-public-ip" {
  value = aws_instance.node-app-ec2.public_ip
}

# output "node-app-ec2-private-ip" {
#   value = aws_instance.node-app-ec2.private_ip
# }