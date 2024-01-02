
resource "aws_key_pair" "tf-key-pair" {
  key_name   = "tf-key-pair89818"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tf-key-pair89818"
}

resource "aws_instance" "example" {
  count = 2
  ami                         = "ami-074f77adfeee318d3" # Amazon Linux 2 AMI ID
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-0b3fd8cdc676642fb" # Use the appropriate subnet
  associate_public_ip_address = true
  #security_groups = [""]
  #   key_name                    = "tf-key-pair"
  key_name = aws_key_pair.tf-key-pair.key_name

  tags = {
    Name = "instance${count.index + 1}"
  }
}
