terraform {
  cloud {

    organization = "rmitrev-home"

    workspaces {
      name = "rmitrev-dev"
    }
  }
}
