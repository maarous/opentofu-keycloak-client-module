resource "keycloak_openid_client" "openid_client" {
  # -----------------------------------------------------------------------
  # 🟩 Common Client Parameters 🟩
  # -----------------------------------------------------------------------
  realm_id = var.realm

  client_id                 = var.id
  name                      = var.name
  enabled                   = true
  description               = var.description
  login_theme               = var.login_theme
  root_url                  = var.root_url
  base_url                  = var.base_url
  valid_redirect_uris       = local.valid_redirect_uris
  full_scope_allowed        = local.full_scope_allowed
  consent_required          = local.consent_required
  always_display_in_console = local.always_display_in_console
  dynamic "authentication_flow_binding_overrides" {
    for_each = var.authentication_browser_flow_override_name != null ? [1] : []
    content {
      browser_id = data.keycloak_authentication_flow.authentication_browser_flow.id
    }
  }
  extra_config = var.extra_config

  # -----------------------------------------------------------------------
  # 🟧 OpenID Connect Specific Client Parameters 🟧
  # -----------------------------------------------------------------------
  access_type                               = var.access_type
  client_authenticator_type                 = local.client_authenticator_type
  implicit_flow_enabled                     = false
  standard_flow_enabled                     = local.standard_flow_enabled
  direct_access_grants_enabled              = false
  service_accounts_enabled                  = local.service_accounts_enabled
  standard_token_exchange_enabled           = local.standard_token_exchange_enabled
  oauth2_device_authorization_grant_enabled = local.oauth2_device_authorization_grant_enabled
  frontchannel_logout_enabled               = local.frontchannel_logout_enabled
  frontchannel_logout_url                   = var.frontchannel_logout_url
  web_origins                               = local.web_origins
  admin_url                                 = local.admin_url
  pkce_code_challenge_method                = "S256"
  require_dpop_bound_tokens                 = local.require_dpop_bound_tokens
  display_on_consent_screen                 = local.display_on_consent_screen
  consent_screen_text                       = var.consent_screen_text
  exclude_session_state_from_auth_response  = local.exclude_session_state_from_auth_response
  exclude_issuer_from_auth_response         = local.exclude_issuer_from_auth_response

  lifecycle {
    # Prevent attempting to create the openid-connect client when not defined
    enabled = var.type == "openid-connect"
  }
}

resource "keycloak_openid_client_default_scopes" "openid_client_default_scopes" {
  realm_id  = var.realm
  client_id = keycloak_openid_client.openid_client.id

  default_scopes = var.default_scopes

  depends_on = [keycloak_openid_client.openid_client]

  lifecycle {
    # Prevent attempting to create the openid-connect client default scopes when not defined
    enabled = var.type == "openid-connect" && var.default_scopes != null
  }
}
