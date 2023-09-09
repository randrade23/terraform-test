resource "aws_ecs_cluster" "app_cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "app_task" {
  family                   = "app-launch-task"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "app-launch-task",
      "image": "${aws_ecr_repository.app_ecr_repo.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${var.app_port},
          "hostPort": ${var.app_port}
        }
      ],
      "memory": ${var.container_resources.memory},
      "cpu": ${var.container_resources.cpu}
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = var.container_resources.memory
  cpu                      = var.container_resources.cpu
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
}

resource "aws_ecs_service" "app_service" {
  name            = "hello-world-service"
  cluster         = "${aws_ecs_cluster.app_cluster.id}"
  task_definition = "${aws_ecs_task_definition.app_task.arn}"
  launch_type     = "FARGATE"
  desired_count   = 2 

  load_balancer {
    target_group_arn = "${aws_lb_target_group.target_group.arn}" 
    container_name   = "${aws_ecs_task_definition.app_task.family}"
    container_port   = var.app_port
  }

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}"]
    assign_public_ip = true 
    security_groups  = ["${aws_security_group.service_security_group.id}"]
  }
}
