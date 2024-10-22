variable "gh_token" {
  type = string
}

variable "repo_max" {
  type        = number
  description = "num of reps"
  default     = 1

  validation {
    condition     = var.repo_max <= 5
    error_message = "do not deploy more than 5 repos"
  }
}

variable "env" {
  type        = string
  description = "environment"
  validation {
    condition     = contains(["dev", "prod"], var.env)
    error_message = "choose envireonment 'dev'/'prod'"
  }

}

variable "repos" {
  type        = map(map(string))
  description = "Repos"
  validation {
    condition     = length(var.repos) <= var.repo_max
    error_message = "Please do not deploy more reposs than ${var.repo_max}"
  }
}

