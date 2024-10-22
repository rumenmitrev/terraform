output "repo_names" {
  value       = { for i in github_repository.ibasi : i.name => [i.http_clone_url, i.ssh_clone_url] }
  description = "repo names and url"
  sensitive = false
}