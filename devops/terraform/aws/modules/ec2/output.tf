output "public_dns" {
  description = "The instance public_dns"
  value = aws_instance.django_instance.public_dns
}

output "public_ip" {
    description = "The instance public_ip"
    value = aws_instance.django_instance.public_ip
}

output "private_dns" {
  description = "The instance private_dns"
  value = aws_instance.django_instance.private_dns
}

output "private_ip" {
  description = "The instance private_ip"
  value = aws_instance.django_instance.private_ip
}

output "elastic_public_dns" {
  description = "The elastic ip public_dns"
  value = aws_eip.lb.public_dns
}

output "elastic_public_ip" {
    description = "The elastic ip public_ip"
    value = aws_eip.lb.public_ip
}
