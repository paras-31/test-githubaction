resource "aws_instance" "example" {
  count = 2
  ami           = "ami-074f77adfeee318d3" # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"
  subnet_id     = "subnet-0b3fd8cdc676642fb" # Use the appropriate subnet
  associate_public_ip_address = true # Associates a public IPv4 address

  tags = {
    Name = "instance${count.index + 1}"
  }   
}
