# resource "random_id" "random" {
#   byte_length = 2
#   count       = var.counter
# }

resource "github_repository" "ibasi" {
  for_each    = var.repos
  name        = "ibasi-${each.key}"
  description = "${each.value.lang} test repo resource for terraform"
  visibility  = var.env == "dev" ? "private" : "public"
  auto_init   = true
  provisioner "local-exec" {
    command = "gh repo view ${self.name} --web"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -fr ${self.name} "
  }
  # lifecycle {
  #   prevent_destroy = true
  # }
}
resource "terraform_data" "repo-clone" {
  for_each   = var.repos
  depends_on = [github_repository_file.index, github_repository_file.readme]
  provisioner "local-exec" {
    command = "gh repo clone ${github_repository.ibasi[each.key].name}"
  }
}

resource "github_repository_file" "readme" {
  for_each   = var.repos
  repository = github_repository.ibasi[each.key].name
  # repository = "ibasi"
  branch              = "main"
  file                = "README.md"
  content             = "# This is a ${var.env} ${each.key}  repo for ${each.key} devs."
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      content,
    ]

  }
}

resource "github_repository_file" "index" {
  for_each   = var.repos
  repository = github_repository.ibasi[each.key].name
  # repository = "ibasi"
  branch              = "main"
  file                = each.value.filename
  content             = "## Hello ${each.value.lang}"
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      content,
    ]
  }
}

output "repo_names" {
  value       = { for i in github_repository.ibasi : i.name => [i.http_clone_url, i.ssh_clone_url] }
  description = "repo names and url"
  #sensitive = true
}
