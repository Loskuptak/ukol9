output "alb_dns_name" {
  description = "ALB DNS name to access nginx"
  value       = aws_lb.alb.dns_name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.ukol7.name
}

output "subnet_ids" {
  value = data.aws_subnets.default.ids
}