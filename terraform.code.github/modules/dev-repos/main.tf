
# resource "random_id" "random" {
#   byte_length = 2
#   count       = var.counter
# }

resource "github_repository" "ibasi" {
  for_each    = var.repos
  name        = "ibasi-${each.key}-${var.env}"
  description = "${each.value.lang} test repo resource for terraform"
  visibility  = "public" #var.env == "dev" ? "private" : "public"
  auto_init   = true
  dynamic "pages" {
    for_each = each.value.pages ? [1] : []
    content {
      source {
        branch = "main"
        path   = "/"
      }

    }
  }

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
  depends_on = [github_repository_file.main, github_repository_file.readme]
  provisioner "local-exec" {
    command = "gh repo clone ${github_repository.ibasi[each.key].name}"
  }
}

resource "github_repository_file" "readme" {
  for_each   = var.repos
  repository = github_repository.ibasi[each.key].name
  # repository = "ibasi"
  branch = "main"
  file   = "README.md"
  content = templatefile("${path.module}/templates/readme.tftpl", {
    env        = var.env,
    lang       = each.value.lang,
    repos      = each.key,
    authorname = data.github_user.current.name
  })
  overwrite_on_create = true
  # lifecycle {
  #   ignore_changes = [
  #     content,
  #   ]

  # }
}

resource "github_repository_file" "main" {
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

# moved {
#   from = github_repository_file.index
#   to = github_repository_file.main
# }
