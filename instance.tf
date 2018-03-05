resource "aws_instance" "web"{
  ami = "ami-531a4c3c"
  instance_type = "t2.micro"
  vpc_id = "${aws_vpc.assignment.id}"
  key_name = "ziyad_mumbai"
  vpc_security_group_ids = "${aws_security_group.new.id}"
  associate_public_ip_address = "yes"
}
