terraform {
  required_version = ">= 1.11.0"

  required_providers {
    keycloak = {
      source  = "keycloak/keycloak"
      version = ">= 5.7.0"
    }
  }
}

provider "keycloak" {
  url       = "http://localhost:8080"
  client_id = "admin-cli"
}
