resource "keycloak_saml_client" "saml_client" {
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
  # 🟪 SAML Specific Client Parameters 🟪
  # -----------------------------------------------------------------------
  # General settings
  idp_initiated_sso_url_name    = var.idp_initiated_sso_url_name
  idp_initiated_sso_relay_state = var.idp_initiated_sso_relay_state
  master_saml_processing_url    = var.master_saml_processing_url

  # SAML capabilities
  name_id_format          = local.name_id_format
  force_name_id_format    = local.force_name_id_format
  force_post_binding      = local.force_post_binding
  include_authn_statement = local.include_authn_statement

  # Signature and Encryption
  client_signature_required           = local.client_signature_required
  sign_documents                      = local.sign_documents
  sign_assertions                     = local.sign_assertions
  signature_algorithm                 = local.signature_algorithm
  signature_key_name                  = local.signature_key_name
  signing_certificate                 = var.signing_certificate
  signing_private_key                 = var.signing_private_key
  canonicalization_method             = local.canonicalization_method
  encrypt_assertions                  = local.encrypt_assertions
  encryption_algorithm                = local.encryption_algorithm
  encryption_key_algorithm            = local.encryption_key_algorithm
  encryption_digest_method            = local.encryption_digest_method
  encryption_mask_generation_function = local.encryption_mask_generation_function
  encryption_certificate              = var.encryption_certificate

  # Logout settings
  front_channel_logout = local.front_channel_logout

  # Fine Grain SAML Endpoint Configuration
  assertion_consumer_post_url         = var.assertion_consumer_post_url
  assertion_consumer_redirect_url     = var.assertion_consumer_redirect_url
  logout_service_post_binding_url     = var.logout_service_post_binding_url
  logout_service_redirect_binding_url = var.logout_service_redirect_binding_url

  lifecycle {
    # Prevent attempting to create the saml client when not defined
    enabled = var.type == "saml"
  }
}

resource "keycloak_saml_client_default_scopes" "saml_client_default_scopes" {
  realm_id  = var.realm
  client_id = keycloak_saml_client.saml_client.id

  default_scopes = var.default_scopes

  depends_on = [keycloak_saml_client.saml_client]

  lifecycle {
    # Prevent attempting to create the saml client default scopes when not defined
    enabled = var.type == "saml" && var.default_scopes != null
  }
}
