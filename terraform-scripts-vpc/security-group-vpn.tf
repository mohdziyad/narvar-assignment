resource "aws_security_group" "openvpn"{
  name = "openvpn client connect"
  description = "UDP port open for openvpn clients access"
  vpc_id = "${aws_vpc.assignment.id}"
  ingress{
    from_port = "1194"
    to_port = "1194"
    protocol = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
