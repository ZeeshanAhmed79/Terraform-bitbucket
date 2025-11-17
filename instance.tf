resource "aws_instance" "Server" {
    ami = ""
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [ aws_security_group.public-sg.id ]
    associate_public_ip_address = true

    tags = {
        Name = "server"
    }
}