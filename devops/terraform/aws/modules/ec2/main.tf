resource "aws_iam_instance_profile" "django_profile" {
  name = "django_profile"
  role = aws_iam_role.ec2_django_access_role.name
}

resource "aws_iam_role" "ec2_django_access_role" {
  name = "django_instance-access-role"
  assume_role_policy = file("ec2_assumerolepolicy.json")
}

resource "aws_iam_policy_attachment" "django-iam-attach" {
  name = "django-iam-attach"
  roles = ["${aws_iam_role.ec2_django_access_role.name}"]
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_policy" "policy" {
  name = "django_instance-access-policy"
  description = "django_instance-policy"
  policy = file("ec2_policy_django_permissions.json")
}


resource "aws_security_group" "django_instance-sg" {
  name = "django_instance-sg"
  description = "Django Dev Security Group"

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP connections backend"
    protocol = "tcp"
    from_port = var.backend_port
    to_port = var.backend_port
    self = true
  }

  egress {
    description = "All traffic is allowed to leave the VPC"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "django-sg"
    Environment = "${var.environment}"
  }
}

resource "aws_instance" "django_instance" {
  availability_zone = var.availability_zone
  ami = var.ami
  security_groups = ["${aws_security_group.django_instance-sg.name}"]
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.django_profile.name
  user_data = file("ec2_userdata.sh")
  key_name = "${var.key_name}"
  associate_public_ip_address = true

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = "${var.volume_size}"
    volume_type = "gp2"
    delete_on_termination = "true"
    encrypted = "false"
  }

  tags = {
    Name = "django_instance"
    Environment = "${var.environment}"
  }

  volume_tags = {
    Name = "django_instance"
    Environment = "${var.environment}"
  }
}

### Elastic IP
resource "aws_eip" "lb" {
  instance = aws_instance.django_instance.id

  tags = {
    Name = "django-elastic-ip"
    Environment = "${var.environment}"
  }
}

### Route 53
# resource "aws_route53_zone" "primary" {
#   name = "${var.embalae_dns_url}"

#   tags = {
#     Name = "django-zone"
#     Environment = "${var.environment}"
#   }
# }

# resource "aws_route53_record" "stars" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "*.${var.embalae_dns_url}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_eip.lb.public_ip]
# }

# resource "aws_route53_record" "www" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "www.${var.embalae_dns_url}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_eip.lb.public_ip]
# }

# resource "aws_route53_record" "empty" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "${var.embalae_dns_url}"
#   type    = "A"
#   ttl     = 300
#   records = [aws_eip.lb.public_ip]
# }
