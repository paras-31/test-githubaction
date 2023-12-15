resource "aws_instance" "example" {
  count = 2
  ami           = "ami-06791f9213cbb608b" # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"
  security_groups = "sg-0f8c32d56a8691587"
  subnet_id     = "	subnet-0b3fd8cdc676642fb" # Use the appropriate subnet
  user_data     = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd 
              sudo systemctl start httpd
              sudo systemctl enable httpd
              sudo su
              echo "<h1> hello world from $(hostname -f)</h1>" > /var/www/html/index.html
              EOF
  associate_public_ip_address = true # Associates a public IPv4 address

  tags = {
    Name = "instance${count.index + 1}"
  }   
}
