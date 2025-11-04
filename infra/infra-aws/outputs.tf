output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.this.dns_name
}

output "frontend_url" {
  description = "Frontend URL"
  value       = "http://${aws_lb.this.dns_name}"
}

output "backend_base_url" {
  description = "Backend base URL (behind /api)"
  value       = "http://${aws_lb.this.dns_name}/api"
}


