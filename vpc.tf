
resource "aws_vpc "assignment"{
  cidr_block = "10.0.0.0/16"
  tags  {
    Name = "assignment-1"
  }
}
