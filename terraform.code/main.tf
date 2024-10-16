resource "random_id" "random" {
  byte_length = 2
  count       = 2
}

resource "github_repository" "ibasi" {
  count       = 2
  name        = "ibasi-${random_id.random[count.index].dec}"
  description = "Test repo resource for terraform"
  visibility  = "private"
  auto_init   = true

}

resource "github_repository_file" "readme" {
    count = 2
    depends_on = [ github_repository.ibasi ]
    repository = github_repository.ibasi[count.index].name
    # repository = "ibasi"
    branch = "main"
    file = "README.md"
    content = "# This is repo for infra devs."
    overwrite_on_create = true
}

resource "github_repository_file" "index" {
    count = 2
    depends_on = [ github_repository.ibasi ]
    repository = github_repository.ibasi[count.index].name
    # repository = "ibasi"
    branch = "main"
    file = "index.html"
    content = "## Hello Terraform"
    overwrite_on_create = true
}
