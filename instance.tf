# 7. EC2 Instance (Public)
resource "aws_instance" "public_ec2" {
  ami                         = "ami-02b8269d5e85954ef"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.mykeypair-pub.key_name
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "public-ec2"
  }
}