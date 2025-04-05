# --------------------------------------
# RDS INSTANCE (LOOSELY COUPLED)
# --------------------------------------
resource "aws_db_subnet_group" "default" {
  name       = "my-db-subnet-group"
  subnet_ids = [
    aws_subnet.private.id,
    aws_subnet.private_b.id
  ]
}

resource "aws_db_instance" "default" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "mydb"
  username               = "admin"
  password               = "YourSecurePassword123!"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name
}