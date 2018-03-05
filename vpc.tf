
resource "aws_vpc" "assignment"{
  cidr_block = "10.0.0.0/16"
  tags  {
    Name = "assignment-1"
  }
}
resource "aws_internet_gateway" "a-igw"{
  vpc_id = "${aws_vpc.assignment.id}"
}
resource "aws_subnet" "a_pub_sub"{
  vpc_id = "${aws_vpc.assignment.id}"
  cidr_block = "10.0.1.0/24"
}
