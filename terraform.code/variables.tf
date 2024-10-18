variable "gh_token" {
  type = string
}

variable "counter" {
  type        = number
  description = "num of reps"
  default     = 1

  validation {
    condition     = var.counter < 5
    error_message = "do not deploy more than 5 repos"
  }
}

variable "env" {
  type = string
  description = "environment"
  validation {
    condition = contains (["dev", "prod"], var.env)
    error_message = "choose envireonment 'dev'/'prod'"
  }
  
}

variable "repos" {
  type = set(string)
  description = "Repos"
}

