locals {
  repos = {
    infra = {
      lang     = "terraform",
      filename = "main.tf",
      pages    = true
    },
    backend = {
      lang     = "python",
      filename = "main.py",
      pages    = false
    }
  }
  environment = toset(["prod", "dev"])
}
module "repos" {
  source   = "./modules/dev-repos"
  for_each = local.environment
  gh_token = ""
  repo_max = 9
  env      = each.key
  repos    = local.repos
}

output "repo-info" {
  value = {for k,v in module.repos : k => v }
}
