
resource "aws_instance" "test" {
  ami = "ami-531a4c3c"
  instance_type = "t2.micro"
}
