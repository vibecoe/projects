
resource "aws_launch_template" "app" {
  name_prefix   = "webAppSuite-app-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.app.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "webAppSuite-app-instance"
    }
  }
}

resource "aws_autoscaling_group" "app" {
  name                 = "webAppSuite-app-asg"
  desired_capacity     = 2
  max_size             = 5
  min_size             = 2
  vpc_zone_identifier  = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}

resource "aws_db_instance" "webAppSuite" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = var.db_instance_class
  db_name              = "webAppSuite"
  username             = "admin"
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.db.id]
  db_subnet_group_name = aws_db_subnet_group.webAppSuite.name
}

resource "aws_db_subnet_group" "webAppSuite" {
  name       = "webAppSuite-db-subnet-group"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name = "WebAppSuite DB subnet group"
  }
}

resource "aws_lb" "webAppSuite" {
  name               = "webAppSuite-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

resource "aws_lb_target_group" "app" {
  name     = "webAppSuite-app-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.webAppSuite.id
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.webAppSuite.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_autoscaling_attachment" "app" {
  autoscaling_group_name = aws_autoscaling_group.app.name
  lb_target_group_arn   = aws_lb_target_group.app.arn
}
