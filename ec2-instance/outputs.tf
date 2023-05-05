output "instance_id" {
  value = aws_instance.my-app-example-1.id
}

output "public_ip" {
  value = aws_instance.my-app-example-1.public_ip
}
