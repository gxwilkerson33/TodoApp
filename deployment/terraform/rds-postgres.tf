#create a RDS Database Instance
resource "aws_db_instance" "action_items_postgres_db" {
  engine                 = "Postgres"
  db_name                = "action_items_postgres_db"
  identifier             = "action-items-postgres-db"
  allocated_storage      = 20
  engine_version         = "15.4"
  instance_class         = "db.t3.micro"
  username               = "postgres"
  password               = data.aws_secretsmanager_secret_version.password.secret_string
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.postgres_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.action_items_db_subnet_group.id

  depends_on = [ aws_secretsmanager_secret.password ]
}

resource "aws_db_subnet_group" "action_items_db_subnet_group" {
  name       = "action-items-db-subnet-group"
  subnet_ids = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id]
}
