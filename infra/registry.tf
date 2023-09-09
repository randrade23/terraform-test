resource "aws_ecr_repository" "app_ecr_repo" {
  name = var.repository_name
}

output "app_repository_url" {
  value = aws_ecr_repository.app_ecr_repo.repository_url
}
