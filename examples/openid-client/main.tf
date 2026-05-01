# Exemple : client OpenID Connect
module "client" {
  source = "../../"

  realm       = "my-realm"
  type        = "openid-connect"
  id          = "my-client"
  name        = "my-client"
  description = "OpenID Connect client example"
  access_type = "PUBLIC"
  root_url    = "https://myapp.example.com"
}
