# Erstelle eine neue VPC
resource "aws_vpc" "Modul_346_Nick_Gilgen" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "M VPC"
  }
}

# Internet GW Definieren
resource "aws_internet_gateway" "m346_gateway" {
  vpc_id = aws_vpc.Modul_346_Nick_Gilgen.id
}

# Subnet für Server (EC2 Instanzen)  anlegen
resource "aws_subnet" "modul346_subnet" {
  vpc_id                  = aws_vpc.Modul_346_Nick_Gilgen.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "M Server Subnet"
  }
}

# Subnet für Datenbank (RDS) anlegen
resource "aws_subnet" "modul_346_rds_subnet" {
  vpc_id                  = aws_vpc.Modul_346_Nick_Gilgen.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "M Database Subnet"
  }
}

# Routing Table konfigurieren, damit ins Internet zugegriffen werden kann
resource "aws_route_table" "routingtable" {
  vpc_id = aws_vpc.Modul_346_Nick_Gilgen.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.m346_gateway.id
  }
}

#Definierte Routing Table mit dem Server Subnetz asoziieren
resource "aws_route_table_association" "modul346_subnet_association" {
  subnet_id      = aws_subnet.modul346_subnet.id
  route_table_id = aws_route_table.routingtable.id
}

# SSH Zugriff von Remote erlauben
resource "aws_security_group" "allow_ssh" {
  vpc_id = aws_vpc.Modul_346_Nick_Gilgen.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# DB und Web Zugriff erlauben
resource "aws_security_group" "allow_dbweb" {
  vpc_id = aws_vpc.Modul_346_Nick_Gilgen.id

  # Erlaubt Access vom Internet (0.0.0.0/0 auf P3000 )
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Erlaubt Kommunikation innerhalb des Srv Subnetzes TCP
  ingress {
    from_port   = 0
    to_port     = 3500
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  # Erlaubt Kommunikation innerhalb des Srv Subnetzes UDP
  ingress {
    from_port   = 0
    to_port     = 3500
    protocol    = "udp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  # Erlaubt Kommunikation innerhalb des Srv Subnetzes ICMP (Ping)
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.1.0/24"]
  }
}

# EC2 Instanz für Webserver anlegen
resource "aws_instance" "web_server01" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployment.key_name
  subnet_id              = aws_subnet.modul346_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_dbweb.id]

  tags = {
    Name = "Webserver01"
  }
}

# RDS DB Subnet Group erstellen
resource "aws_db_subnet_group" "m346_db_subnet_group" {
  name       = "m141_db_subnetgroup"
  subnet_ids = [aws_subnet.modul346_subnet.id, aws_subnet.modul_346_rds_subnet.id]

  tags = {
    Name = "My DB Subnet Group"
  }
}

# RDS DB Instanz erstellen
resource "aws_db_instance" "WS1-346" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.25"
  instance_class       = "db.t3.micro"
  identifier           = "Vmadmin"
  username             = "Vmadmin"
  password             = "sml12345"
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_grou346.name
}
