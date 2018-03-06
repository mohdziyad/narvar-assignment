resource "aws_key_pair" "deploy"{
  key_name = "web-deploy"
  public_key = "${file("/home/vagrant/.ssh/id_rsa.pub")}"
}
resource "aws_instance" "web"{
  ami = "ami-531a4c3c"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.a_pub_sub.id}"
  key_name = "web-deploy"
  vpc_security_group_ids = ["${aws_security_group.new.id}"]
  associate_public_ip_address = "true"
  tags{
    Name = "web-instance"
  }
}
