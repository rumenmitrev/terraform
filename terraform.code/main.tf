# resource "random_id" "random" {
#   byte_length = 2
#   count       = var.counter
# }

resource "github_repository" "ibasi" {
  for_each       = var.repos
  name        = "ibasi-${each.key}"
  description = "Test repo resource for terraform"
  visibility  = var.env == "dev" ? "private" : "public"
  auto_init   = true

}

resource "github_repository_file" "readme" {
  for_each = var.repos
  depends_on = [github_repository.ibasi]
  repository = github_repository.ibasi[each.key].name
  # repository = "ibasi"
  branch              = "main"
  file                = "README.md"
  content             = "# This ${var.env} is repo for infra devs."
  overwrite_on_create = true
}

resource "github_repository_file" "index" {
  for_each = var.repos
  depends_on = [github_repository.ibasi]
  repository = github_repository.ibasi[each.key].name
  # repository = "ibasi"
  branch              = "main"
  file                = "index.html"
  content             = "## Hello Terraform"
  overwrite_on_create = true
}

output "repo_names" {
  value       = { for i in github_repository.ibasi : i.name => i.http_clone_url }
  description = "repo names and url"
  #sensitive = true
}
