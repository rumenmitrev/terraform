output "repo_names" {
  value = { for i in github_repository.ibasi : i.name => {
    ssh-url   = i.http_clone_url,
    clone_url = i.ssh_clone_url,
 #   home_page = i.pages[0].html_url
    }
  }
  description = "repo names and url"
  sensitive   = false
}