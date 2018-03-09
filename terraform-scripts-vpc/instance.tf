resource "aws_key_pair" "deploy"{
  key_name = "web-deploy"
  public_key = "${file("/home/vagrant/.ssh/id_rsa.pub")}"
}
resource "aws_instance" "web"{
  ami = "ami-84e3b2eb"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.a_pub_sub.id}"
  key_name = "web-deploy"
  vpc_security_group_ids = ["${aws_security_group.new.id}","${aws_security_group.openvpn.id}"]
  associate_public_ip_address = "true"
  iam_instance_profile = "${aws_iam_instance_profile.ec2-instance-profile.name}"
  tags{
    Name = "web-instance"
  }
}
