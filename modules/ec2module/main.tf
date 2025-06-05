data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_instance" "this" {
  ami = data.aws_ami.this.id
  instance_type = "t2.micro"
  tags = {
    Name = var.instance_name
    github = "https://github.com/Eddie-Herrera-RCH/LearnTerraformModules.git"
    createdBy = "Terraform"
    date = formatdate("MMM-DD-YYYY", timestamp())
  }
}