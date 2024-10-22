gh_token = ""
repo_max = 2
env      = "dev"
repos = {
  infra = {
    lang     = "terraform",
    filename = "main.tf"
  },
  backend = {
    lang     = "python",
    filename = "main.py"
  }
#   frontend = {
#     lang     = "javascript"
#     filename = "main.js"
#   }
}