variables {
  realm = "my-realm"
}

mock_provider "keycloak" {
  alias = "mock"
}

run "saml_client" {
  providers = {
    keycloak = keycloak.mock
  }

  variables {
    type                                      = "saml"
    id                                        = "https://app.example.test"
    name                                      = "Test SAML client"
    description                               = "Client SAML for tofu test"
    root_url                                  = "https://app.example.test"
    authentication_browser_flow_override_name = "browser test"

    # General settings
    master_saml_processing_url = "https://app.example.test/saml/master"

    # SAML capabilities
    client_signature_required = true
    force_name_id_format      = true

    # Signature and Encryption
    sign_documents          = false
    sign_assertions         = true
    canonicalization_method = "INCLUSIVE"
    signing_certificate     = "-----BEGIN CERTIFICATE-----\nMIIB...\n-----END CERTIFICATE-----"
    signing_private_key     = "-----BEGIN PRIVATE KEY-----\nMIIE...\n-----END PRIVATE KEY-----"
    encrypt_assertions      = true
    encryption_certificate  = "-----BEGIN CERTIFICATE-----\nMIIB...\n-----END CERTIFICATE-----"

    default_scopes = ["scope1", "scope2", "scope3"]
  }

  command = plan

  override_data {
    target = data.keycloak_authentication_flow.authentication_browser_flow

    values = {
      id = "0ZrPsoiIpwJ8tm"
    }
  }

  assert {
    condition     = keycloak_saml_client.saml_client.realm_id == "my-realm"
    error_message = "realm_id should be 'my-realm'"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.client_id == "https://app.example.test"
    error_message = "client_id should match the provided id"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.name == "Test SAML client"
    error_message = "name should match the provided name"
  }

  assert {
    condition     = data.keycloak_authentication_flow.authentication_browser_flow.id == "0ZrPsoiIpwJ8tm"
    error_message = "authentication_flow_binding_overrides must match the browser id associated with the configured authentication_browser_flow_override_name"
  }

  # General settings
  assert {
    condition     = keycloak_saml_client.saml_client.master_saml_processing_url == "https://app.example.test/saml/master"
    error_message = "master_saml_processing_url should match the provided value"
  }

  # SAML capabilities
  assert {
    condition     = keycloak_saml_client.saml_client.include_authn_statement == true
    error_message = "include_authn_statement should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.client_signature_required == true
    error_message = "client_signature_required should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.force_post_binding == true
    error_message = "force_post_binding should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.name_id_format == "email"
    error_message = "name_id_format should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.force_name_id_format == true
    error_message = "force_name_id_format should match the provided value"
  }

  # Signature and Encryption
  assert {
    condition     = keycloak_saml_client.saml_client.sign_documents == false
    error_message = "sign_documents should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.sign_assertions == true
    error_message = "sign_assertions should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.signature_algorithm == "RSA_SHA256"
    error_message = "signature_algorithm should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.signature_key_name == "KEY_ID"
    error_message = "signature_key_name should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.canonicalization_method == "INCLUSIVE"
    error_message = "canonicalization_method should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.signing_certificate == "-----BEGIN CERTIFICATE-----\nMIIB...\n-----END CERTIFICATE-----"
    error_message = "signing_certificate should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.signing_private_key == "-----BEGIN PRIVATE KEY-----\nMIIE...\n-----END PRIVATE KEY-----"
    error_message = "signing_private_key should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.encrypt_assertions == true
    error_message = "encrypt_assertions should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.encryption_key_algorithm == "RSA-OAEP-11"
    error_message = "encryption_key_algorithm should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.encryption_digest_method == "SHA-256"
    error_message = "encryption_digest_method should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.encryption_mask_generation_function == "mgf1sha256"
    error_message = "encryption_mask_generation_function should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.encryption_algorithm == "AES_256_GCM"
    error_message = "encryption_algorithm should match the provided value"
  }

  assert {
    condition     = keycloak_saml_client.saml_client.encryption_certificate == "-----BEGIN CERTIFICATE-----\nMIIB...\n-----END CERTIFICATE-----"
    error_message = "encryption_certificate should match the provided value"
  }

  # Logout settings
  assert {
    condition     = keycloak_saml_client.saml_client.front_channel_logout == true
    error_message = "front_channel_logout should match the provided value"
  }

  assert {
    condition = alltrue([
      contains(keycloak_saml_client_default_scopes.saml_client_default_scopes.default_scopes, "scope1"),
      contains(keycloak_saml_client_default_scopes.saml_client_default_scopes.default_scopes, "scope2"),
      contains(keycloak_saml_client_default_scopes.saml_client_default_scopes.default_scopes, "scope3"),
    ])
    error_message = "default_scopes for saml client should include scope1, scope2 and scope3"
  }
}
