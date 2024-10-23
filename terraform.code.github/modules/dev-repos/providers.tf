terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

# provider "github" {
#   # Configuration options
#   token = var.gh_token
#   owner = "rumenmitrev"
# }
