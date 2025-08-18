variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "project_name" {
  description = "prefix pro projekt"
  default     = "ukol7"
}
variable "nginx_image" {
  type    = string
  default = "664304972269.dkr.ecr.eu-central-1.amazonaws.com/nginx-custom:latest"
}

variable "allowed_cidr" {
  description = "ALB ingress pokus nemít jeden v mainu"
  type        = string
  default     = "0.0.0.0/0"  
}

