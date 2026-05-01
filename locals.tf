locals {
  # -----------------------------------------------------------------------
  # 🟩 Common Client Variables - Default Values 🟩
  # -----------------------------------------------------------------------
  valid_redirect_uris       = (var.valid_redirect_uris == null ? ["${var.root_url}/*"] : var.valid_redirect_uris)
  full_scope_allowed        = (var.full_scope_allowed == null ? true : var.full_scope_allowed)
  consent_required          = (var.consent_required == null ? false : var.consent_required)
  always_display_in_console = (var.always_display_in_console == null ? true : var.always_display_in_console)

  # -----------------------------------------------------------------------
  # 🟧 Specific OpenID Connect Client Variables - Default Values 🟧
  # -----------------------------------------------------------------------
  client_authenticator_type                 = (var.type == "openid-connect" && var.client_authenticator_type == null && var.access_type == "CONFIDENTIAL") ? "client-secret" : var.client_authenticator_type
  standard_flow_enabled                     = (var.type == "openid-connect" && var.standard_flow_enabled == null) ? true : var.standard_flow_enabled
  service_accounts_enabled                  = (var.type == "openid-connect" && var.service_accounts_enabled == null) ? false : var.service_accounts_enabled
  standard_token_exchange_enabled           = (var.type == "openid-connect" && var.standard_token_exchange_enabled == null) ? false : var.standard_token_exchange_enabled
  oauth2_device_authorization_grant_enabled = (var.type == "openid-connect" && var.oauth2_device_authorization_grant_enabled == null) ? false : var.oauth2_device_authorization_grant_enabled
  web_origins                               = (var.type == "openid-connect" && var.web_origins == null) ? [var.root_url] : var.web_origins
  admin_url                                 = (var.type == "openid-connect" && var.admin_url == null) ? var.root_url : var.admin_url
  exclude_session_state_from_auth_response  = (var.type == "openid-connect" && var.exclude_session_state_from_auth_response == null) ? false : var.exclude_session_state_from_auth_response
  frontchannel_logout_enabled               = (var.type == "openid-connect" && var.frontchannel_logout_enabled == null) ? true : var.frontchannel_logout_enabled
  require_dpop_bound_tokens                 = (var.type == "openid-connect" && var.require_dpop_bound_tokens == null) ? false : var.require_dpop_bound_tokens
  display_on_consent_screen                 = (var.type == "openid-connect" && var.display_on_consent_screen == null) ? false : var.display_on_consent_screen
  exclude_issuer_from_auth_response         = (var.type == "openid-connect" && var.exclude_issuer_from_auth_response == null) ? false : var.exclude_issuer_from_auth_response

  # -----------------------------------------------------------------------
  # 🟪 Specific SAML Client Variables - Default Values 🟪
  # -----------------------------------------------------------------------
  # SAML capabilities
  name_id_format          = (var.type == "saml" && var.name_id_format == null) ? "email" : var.name_id_format
  force_name_id_format    = (var.type == "saml" && var.force_name_id_format == null) ? false : var.force_name_id_format
  force_post_binding      = (var.type == "saml" && var.force_post_binding == null) ? true : var.force_post_binding
  include_authn_statement = (var.type == "saml" && var.include_authn_statement == null) ? true : var.include_authn_statement

  # Signature and Encryption
  client_signature_required           = (var.type == "saml" && var.client_signature_required == null) ? true : var.client_signature_required
  sign_documents                      = (var.type == "saml" && var.sign_documents == null) ? true : var.sign_documents
  sign_assertions                     = (var.type == "saml" && var.sign_assertions == null) ? false : var.sign_assertions
  signature_algorithm                 = (var.type == "saml" && var.signature_algorithm == null) ? "RSA_SHA256" : var.signature_algorithm
  signature_key_name                  = (var.type == "saml" && var.signature_key_name == null) ? "KEY_ID" : var.signature_key_name
  canonicalization_method             = (var.type == "saml" && var.canonicalization_method == null) ? "EXCLUSIVE" : var.canonicalization_method
  encrypt_assertions                  = (var.type == "saml" && var.encrypt_assertions == null) ? false : var.encrypt_assertions
  encryption_algorithm                = (var.type == "saml" && var.encryption_algorithm == null && var.encrypt_assertions == true) ? "AES_256_GCM" : var.encryption_algorithm
  encryption_key_algorithm            = (var.type == "saml" && var.encryption_key_algorithm == null && var.encrypt_assertions == true) ? "RSA-OAEP-11" : var.encryption_key_algorithm
  encryption_digest_method            = (var.type == "saml" && var.encryption_digest_method == null && var.encrypt_assertions == true && var.encryption_key_algorithm == null) ? "SHA-256" : var.encryption_digest_method
  encryption_mask_generation_function = (var.type == "saml" && var.encryption_mask_generation_function == null && var.encrypt_assertions == true && var.encryption_key_algorithm == null) ? "mgf1sha256" : var.encryption_mask_generation_function

  # Logout settings
  front_channel_logout = (var.type == "saml" && var.front_channel_logout == null) ? true : var.front_channel_logout
}
