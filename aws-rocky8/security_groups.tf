resource "aws_security_group" "allow_all" {
  name_prefix = "${var.env_prefix}-allow_all"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  // "-1" means all protocols
    cidr_blocks = ["${var.my_ip}/32", "10.0.2.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_prefix}-sg"
  }
}
