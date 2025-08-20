# proměnné
variable "project_name" {
  type    = string
  default = "nukol7"
}

variable "ecs_cluster_name" {
  type    = string
  default = "ecs-nukol7-cluster"
}

variable "ecs_service_name" {
  type    = string
  default = "nginx-service"
}

# grafy
resource "aws_cloudwatch_dashboard" "ecs_service_dashboard" {
  dashboard_name = "ECS-${var.ecs_service_name}-Dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        "type"  : "metric",
        "x"     : 0,
        "y"     : 0,
        "width" : 12,
        "height": 6,
        "properties": {
          "title" : "kolik CPU - ${var.ecs_service_name}",
          "stat"  : "Average",
          "period": 60,
          "view"  : "timeSeries",
          "region": "eu-central-1",
          "metrics": [
            [ "AWS/ECS", "CPUUtilization", "ClusterName", var.ecs_cluster_name, "ServiceName", var.ecs_service_name ]
          ],
          "yAxis": { "left": { "min": 0, "max": 100 } }
        }
      },
      {
        "type"  : "metric",
        "x"     : 12,
        "y"     : 0,
        "width" : 12,
        "height": 6,
        "properties": {
          "title" : "Memory Graf - ${var.ecs_service_name}",
          "stat"  : "Average",
          "period": 60,
          "view"  : "timeSeries",
          "region": "eu-central-1",
          "metrics": [
            [ "AWS/ECS", "MemoryUtilization", "ClusterName", var.ecs_cluster_name, "ServiceName", var.ecs_service_name ]
          ],
          "yAxis": { "left": { "min": 0, "max": 100 } }
        }
      }
    ]
  })
}