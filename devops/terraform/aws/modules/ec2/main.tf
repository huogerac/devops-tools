resource "aws_iam_instance_profile" "django_prod_profile" {
  name = "django_prod_profile"
  role = aws_iam_role.ec2_django_access_role.name
}

resource "aws_iam_role" "ec2_django_access_role" {
  name = "django-prod-access-role"
  assume_role_policy = file("assumerolepolicy.json")
}

resource "aws_iam_policy_attachment" "django-iam-attach" {
  name = "django-iam-attach"
  roles = ["${aws_iam_role.ec2_django_access_role.name}"]
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_policy" "policy" {
  name = "django-prod-access-policy"
  description = "django-prod-policy"
  policy = file("policy_django_permissions.json")
}


resource "aws_security_group" "django-prod-sg" {
  name = "django-prod-sg"
  description = "Django Prod Security Group"

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
    Name = "django-sg-prod"
    Environment = "${var.environment}"
  }
}

resource "aws_instance" "django-prod" {
  availability_zone = var.availability_zone
  ami = var.ami
  security_groups = ["${aws_security_group.django-prod-sg.name}"]
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.django_prod_profile.name
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
    Name = "django-prod"
    Environment = "${var.environment}"
  }

  volume_tags = {
    Name = "django-prod"
    Environment = "${var.environment}"
  }
}

