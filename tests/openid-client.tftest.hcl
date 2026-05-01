variables {
  realm = "my-realm"
}

mock_provider "keycloak" {
  alias = "mock"
}

run "openid_connect_client" {
  providers = {
    keycloak = keycloak.mock
  }

  variables {
    type                      = "openid-connect"
    id                        = "test-oidc-client"
    name                      = "Test OIDC client"
    description               = "Client OpenID Connect for tofu test"
    root_url                  = "https://app.example.test"
    access_type               = "CONFIDENTIAL"
    client_authenticator_type = "client-jwt"
    service_accounts_enabled  = true
    full_scope_allowed        = false
    consent_required          = true
    display_on_consent_screen = true

    default_scopes = ["scope1", "scope2", "scope3"]
  }

  command = plan

  assert {
    condition     = keycloak_openid_client.openid_client.realm_id == "my-realm"
    error_message = "realm_id should be 'my-realm'"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.client_id == "test-oidc-client"
    error_message = "client_id should match the provided id"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.name == "Test OIDC client"
    error_message = "name should match the provided name"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.access_type == "CONFIDENTIAL"
    error_message = "access_type should match the provided access_type"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.client_authenticator_type == "client-jwt"
    error_message = "client_authenticator_type should match the provided client_authenticator_type"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.service_accounts_enabled == true
    error_message = "service_accounts_enabled should match the provided value"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.full_scope_allowed == false
    error_message = "full_scope_allowed should match the provided value"
  }

  assert {
    condition     = contains(keycloak_openid_client.openid_client.valid_redirect_uris, "${var.root_url}/*")
    error_message = "valid_redirect_uris should default to [\"${var.root_url}/*\"] when not provided"
  }

  assert {
    condition     = contains(keycloak_openid_client.openid_client.web_origins, "${var.root_url}")
    error_message = "web_origins should default to [\"${var.root_url}\"] when not provided"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.admin_url == "${var.root_url}"
    error_message = "admin_url should default to ${var.root_url} when not provided"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.pkce_code_challenge_method == "S256"
    error_message = "pkce_code_challenge_method be 'S256'"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.frontchannel_logout_enabled == true
    error_message = "frontchannel_logout_enabled should default to true when not provided"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.require_dpop_bound_tokens == false
    error_message = "require_dpop_bound_tokens should default to false when not provided"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.consent_required == true
    error_message = "consent_required should match the provided value"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.display_on_consent_screen == true
    error_message = "display_on_consent_screen should match the provided value"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.exclude_issuer_from_auth_response == false
    error_message = "exclude_issuer_from_auth_response should default to false when not provided"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.standard_token_exchange_enabled == false
    error_message = "standard_token_exchange_enabled should default to false when not provided"
  }

  assert {
    condition     = keycloak_openid_client.openid_client.oauth2_device_authorization_grant_enabled == false
    error_message = "oauth2_device_authorization_grant_enabled should default to false when not provided"
  }

  assert {
    condition = alltrue([
      contains(keycloak_openid_client_default_scopes.openid_client_default_scopes.default_scopes, "scope1"),
      contains(keycloak_openid_client_default_scopes.openid_client_default_scopes.default_scopes, "scope2"),
      contains(keycloak_openid_client_default_scopes.openid_client_default_scopes.default_scopes, "scope3"),
    ])
    error_message = "default_scopes for openid client should include scope1, scope2 and scope3"
  }
}
