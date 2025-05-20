resource aws_key_pair my-keypair {
key_name = "my-key-123" 
public_key = "abcdef12345" or file("filename") #provide your public key here
}

resource aws_default_vpc default {
}

resource aws_default_security_group my-sg {
vpc_id = aws_default_vpc.default.id

ingress {
 from_port = 22
 to_port = 22
 cidr_blocks = ["0.0.0.0/0"]
 protocol = "tcp"
 description = "ssh"
}

egress{
 from_port = 0
 to_port = 0
 protocol = -1
 cidr_blocks = ["0.0.0.0/0"]
}

tags = {

name = "automate" #security group name
}

}

resource "aws_instance" "my-instance" {

vpc_security_group_ids = [aws_default_security_group.my-sg.id]
key_name = aws_key_pair.my-keypair.key_name 
instance_type = "t2.micro"
ami = "ami-0e35ddab05kij8989" # provide ami id

tags = {

Name = "Terraform-instance" # instance name
}

root_block_device {    #storage
    volume_size           = 10
    volume_type           = "gp2"
    delete_on_termination = true
 } 

}
