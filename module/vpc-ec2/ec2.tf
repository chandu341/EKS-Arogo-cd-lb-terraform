resource "aws_instance" "ec2" {
  ami = data.aws_ami.ami.id
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  iam_instance_profile = aws_iam_instance_profile.ec2-instance-profile.id
  subnet_id = aws_subnet.public-subnet[0].id
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  user_data_base64 = base64encode(
  file("${path.module}/userdata.sh")
  ) 
  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = "eks-server-deploy"
  }
}
  