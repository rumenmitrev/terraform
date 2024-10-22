gh_token = ""
repo_max = 2
env      = "prod"
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
  #   frontend = {
  #     lang     = "javascript"
  #     filename = "main.js"
  #   }
}