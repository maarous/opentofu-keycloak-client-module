data "keycloak_authentication_flow" "authentication_browser_flow" {
  realm_id = var.realm
  alias    = var.authentication_browser_flow_override_name

  lifecycle {
    enabled = var.authentication_browser_flow_override_name != null
  }
}
