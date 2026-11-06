# Configuracion del proveedor de AWS
provider "aws" {
  region = "us-east-1" #Region donde se despliegan los recursos
}
#Creamos el security group
resource "aws_security_group" "mi-sg" {
    name = "mi-security-group-terraform-kp" #nombre del security group
    description = "Security group para mi instancia en terraform" #descripcion del terraform
    vpc_id = "vpc-0478126e7e1a4196b" #ID del vps donde se creara el security group
    #Regla de entrada (para ssh):
    ingress  {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    } 
    #Regla de salida (para http):
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
# Declaracion de los recursos a aprovisionar
#Todo lo que quiera aprovisionar es un recurso para terraform
resource "aws_instance" "mi_instancia_kp_2" {
  ami = "ami-0c230065b91270bc6" #ID de la imagen de amazon linux
  instance_type = "t2.micro" #Tipo de instancia
  key_name = "mi-primera-llaves-kp" #nmombre del par de claves para acceder a la instancia
  tags = {
    Name = "MiInstanciaTerraform2" #etiqueta para identificar la instancia
  }
  vpc_security_group_ids = [ aws_security_group.mi-sg.id ] #asignamos el security group a la instancia
}