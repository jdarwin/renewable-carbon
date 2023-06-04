resource "aws_ecs_task_definition" "task_definition" {
  family                = "worker"
  #container_definitions = data.template_file.task_definition_template.rendered
  container_definitions = jsonencode([
    {
      name      = "frontend-SPA"
      image     = "frontend-SPA-image-v1.0"
      cpu       = 2
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },
    {
      name      = "backend-python"
      image     = "backend-python-image-v1.0"
      cpu       = 4
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 443
          hostPort      = 443
        }
      ]
    }
  ])
}