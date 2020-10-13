resource "aws_db_subnet_group" "db-subnet" {
  name       = "sfia2"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "database-2" {
  identifier = "database-2"

  allocated_storage       = var.allocated_storage
  db_subnet_group_name    = "${aws_db_subnet_group.db-subnet.name}"
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  name                    = var.name
  username                = var.username
  password                = var.password
  port                    = var.port
  storage_type            = var.storage_type

  vpc_security_group_ids = var.vpc_security_group_ids


  final_snapshot_identifier = var.final_snapshot_identifier
}

resource "aws_db_instance" "testdb2" {
  identifier = "testdb2"

  allocated_storage       = var.allocated_storage
  db_subnet_group_name    = "${aws_db_subnet_group.db-subnet.name}"
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  name                    = var.name
  username                = var.username
  password                = var.password
  port                    = var.port
  storage_type            = var.storage_type
  publicly_accessible    = true

  vpc_security_group_ids = var.vpc_security_group_ids


  final_snapshot_identifier = var.final_snapshot_identifier
}
