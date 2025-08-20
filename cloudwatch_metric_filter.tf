# log grupa co jsem delal predtim 
data "aws_cloudwatch_log_group" "ecs_lg" {
  name = "/ecs/${var.project_name}"
}

# měrim 200 status code z nginx logu
resource "aws_cloudwatch_log_metric_filter" "nginx_http_200" {
  name           = "nginx-http-200"
  log_group_name = data.aws_cloudwatch_log_group.ecs_lg.name
  pattern = " 200 "

  metric_transformation {
    name      = "HTTP200Count"
    namespace = "Custom/Nginx"
    value     = "1"
    unit      = "Count"
  }
}

# udelam z toho graf
resource "aws_cloudwatch_dashboard" "ecs_service_dashboard_with_200" {
  dashboard_name = aws_cloudwatch_dashboard.ecs_service_dashboard.dashboard_name

  dashboard_body = jsonencode({
    widgets = concat(
      jsondecode(aws_cloudwatch_dashboard.ecs_service_dashboard.dashboard_body).widgets,
      [
        {
          "type"  : "metric",
          "x"     : 0,
          "y"     : 6,
          "width" : 24,
          "height": 6,
          "properties": {
            "title"   : "Nginx HTTP 200 count (sum/5m)",
            "stat"    : "Sum",
            "period"  : 300,
            "view"    : "timeSeries",
            "region"  : var.aws_region,
            "metrics" : [
              [ "Custom/Nginx", "HTTP200Count" ]
            ]
          }
        }
      ]
    )
  })

  depends_on = [aws_cloudwatch_log_metric_filter.nginx_http_200]
}
