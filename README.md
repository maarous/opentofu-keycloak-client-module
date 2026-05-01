# Keycloak Client Opentofu module

Opentofu module which creates and configures a Keycloak client.

## Usage

### Single Client

todo

### Multiple Clients

todo

## Examples

- [OpenID Connect client](https://github.com/maarous/opentofu-keycloak-client-module/tree/master/examples/openid-client)
- [SAML client](https://github.com/maarous/opentofu-keycloak-client-module/tree/master/examples/saml)

## Requirements

| Name                                                                   | Version   |
|------------------------------------------------------------------------|-----------|
| <a name="requirement_opentofu"></a> [opentofu](#requirement\_opentofu) | >= 1.11.0 |
| <a name="requirement_keycloak"></a> [keycloak](#requirement\_keycloak) | >= 5.7.0  |

## Providers

| Name                                                                  | Version  |
|-----------------------------------------------------------------------|----------|
| [keycloak](https://registry.terraform.io/providers/keycloak/keycloak) | >= 5.7.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                               | Type        |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [keycloak_openid_client.openid_client](https://registry.terraform.io/providers/keycloak/keycloak/latest/docs/resources/openid_client)                                              | resource    |
| [keycloak_saml_client.saml_client](https://registry.terraform.io/providers/keycloak/keycloak/latest/docs/resources/saml_client)                                                    | resource    |
| [keycloak_openid_client_default_scopes.openid_client_default_scopes](https://registry.terraform.io/providers/keycloak/keycloak/latest/docs/resources/openid_client_default_scopes) | resource    |
| [keycloak_saml_client_default_scopes.saml_client_default_scopes](https://registry.terraform.io/providers/keycloak/keycloak/latest/docs/resources/saml_client_default_scopes)       | resource    |
| [keycloak_authentication_flow.authentication_browser_flow](https://registry.terraform.io/providers/sharekey/keycloak/latest/docs/data-sources/authentication_flow)                 | data source |

## Inputs

### OpenID Connect Client

| Name                                   | Description                                             | Type           | Default               | Required |
|:--------------------------------------:|:-------------------------------------------------------:|:--------------:|:---------------------:|:--------:|
| `type`                                 | Client type (`saml` or `openid-connect`)                | `string`       | undefined             | yes      |
| `realm`                                | Keycloak realm name                                     | `string`       | undefined             | yes      |
| `id`                                   | Unique Keycloak client identifier                       | `string`       | undefined             | yes      |
| `name`                                 | Keycloak client name                                    | `string`       | undefined             | yes      |
| `description`                          | Client description                                      | `string`       | undefined             | yes      |
| `root_url`                             | Client root URL                                         | `string`       | undefined             | yes      |
| `login_theme`                          | OpenID Connect login theme                              | `string`       | `null`                | no       |
| `base_url`                             | Client base URL                                         | `string`       | `null`                | no       |
| `valid_redirect_uris`                  | List of permitted redirect URIs                         | `list(string)` | [`${var.root_url}/*`] | no       |
| `full_scope_allowed`                   | Allow the client to use the full scope                  | `bool`         | `true`                | no       |
| `consent_required`                     | Require end-user consent for OpenID Connect             | `bool`         | `false`               | no       |
| `always_display_in_console`            | Always display the client in the admin console          | `bool`         | `true`                | no       |
| `authentication_browser_flow_override_name` | Authentication browser flow override name          | `string`       | `null`                | no       |
| `extra_config`                         | Additional OpenID Connect client configuration settings | `map(string)`  | `{}`                  | no       |
| `access_type`                          | OpenID Connect access type (`PUBLIC` or `CONFIDENTIAL`) | `string`       | undefined             | yes      |
| `client_authenticator_type`            | OpenID Connect client authenticator type                | `string`       | `null`                | no       |
| `standard_flow_enabled`                | Enable the standard OpenID Connect authorization flow   | `bool`         | `true`                | no       |
| `service_accounts_enabled`             | Enable service accounts for the client                  | `bool`         | `false`               | no       |
| `web_origins`                          | Allowed web origins                                     | `list(string)` | `[var.root_url]`      | no       |
| `admin_url`                            | Client administration URL                               | `string`       | `var.root_url`        | no       |
| `exclude_session_state_from_auth_response` | Exclude session state from authentication responses | `bool`         | `false`               | no       |
| `frontchannel_logout_enabled`          | Enable frontchannel logout                              | `bool`         | `true`                | no       |
| `frontchannel_logout_url`              | Frontchannel logout URL                                 | `string`       | `null`                | no       |
| `require_dpop_bound_tokens`            | Require DPoP-bound tokens                               | `bool`         | `false`               | no       |
| `display_on_consent_screen`            | Show the client on the consent screen                   | `bool`         | `false`               | no       |
| `consent_screen_text`                  | Consent screen text                                     | `string`       | `null`                | no       |
| `exclude_issuer_from_auth_response`    | Exclude issuer information from auth responses          | `bool`         | `false`               | no       |
| `standard_token_exchange_enabled`      | Enable standard token exchange                          | `bool`         | `false`               | no       |
| `oauth2_device_authorization_grant_enabled`| Enable OAuth2 device authorization grant            | `bool`         | `false`               | no       |
| `default_scopes`                       | Default scopes assigned to the client                   | `list(string)` | `null`                | no       |

> ⚠️ **Note:**
>
> - Required variables depend on the client type (`saml` or `openid-connect`).
> OpenID Connect-specific variables are automatically set to `null` when the client type is not `openid-connect`.
> When `type = "openid-connect"`, default values are applied automatically via `locals.tf`.
>
> - The OpenID Connect client access type `BEARER-ONLY` is deprecated and no longer supported by Keycloak; as a result, this module does not support it.
> You must use the `CONFIDENTIAL` access type instead.

### SAML Client

| Name                                  | Description                                                            | Type           | Default               | Required |
|:-------------------------------------:|:----------------------------------------------------------------------:|:--------------:|:---------------------:|:--------:|
| `type`                                | Client type (`saml` or `openid-connect`)                               | `string`       | undefined             | yes      |
| `realm`                               | Keycloak realm name                                                    | `string`       | undefined             | yes      |
| `id`                                  | Unique Keycloak client identifier                                      | `string`       | undefined             | yes      |
| `name`                                | Keycloak client name                                                   | `string`       | undefined             | yes      |
| `description`                         | Client description                                                     | `string`       | undefined             | yes      |
| `root_url`                            | Client root URL                                                        | `string`       | undefined             | yes      |
| `login_theme`                         | Login theme                                                            | `string`       | `null`                | no       |
| `base_url`                            | Client base URL                                                        | `string`       | [`${var.root_url}/*`] | no       |
| `valid_redirect_uris`                 | List of permitted redirect URIs                                        | `list(string)` | [`${var.root_url}/*`] | no       |
| `full_scope_allowed`                  | Allow the client to use the full scope                                 | `bool`         | `true`                | no       |
| `consent_required`                    | Require end-user consent                                               | `bool`         | `false`               | no       |
| `always_display_in_console`           | Always display the client in the admin console                         | `bool`         | `true`                | no       |
| `extra_config`                        | Additional client configuration settings                               | `map(string)`  | `{}`                  | no       |
| `master_saml_processing_url`          | Primary SAML processing endpoint                                       | `string`       | `null`                | no       |
| `include_authn_statement`             | Include AuthnStatement in the SAML response                            | `bool`         | `false`               | no       |
| `force_post_binding`                  | Force usage of SAML POST binding                                       | `bool`         | `true`                | no       |
| `name_id_format`                      | NameID format (`username`, `email`, `persistent`, `transient`)         | `string`       | `"email"`             | no       |
| `force_name_id_format`                | Force the configured NameID format                                     | `bool`         | `false`               | no       |
| `idp_initiated_sso_url_name`          | IdP-initiated SSO URL name fragment                                    | `string`       | `null`                | no       |
| `idp_initiated_sso_relay_state`       | RelayState value for IdP-initiated SSO                                 | `string`       | `null`                | no       |
| `client_signature_required`           | Require client requests to be signed                                   | `bool`         | `true`                | no       |
| `sign_documents`                      | Sign the SAML document                                                 | `bool`         | `false`               | no       |
| `sign_assertions`                     | Sign assertions when document signing is enabled                       | `bool`         | `false`               | no       |
| `signature_algorithm`                 | Signature algorithm                                                    | `string`       | `"RSA_SHA256"`        | no       |
| `signature_key_name`                  | Signature key name (`NONE`, `KEY_ID`, `CERT_SUBJECT`)                  | `string`       | `"KEY_ID"`            | no       |
| `canonicalization_method`             | XML canonicalization method                                            | `string`       | `"EXCLUSIVE"`         | no       |
| `encrypt_assertions`                  | Encrypt SAML assertions                                                | `bool`         | `false`               | no       |
| `encryption_algorithm`                | Assertion encryption algorithm                                         | `string`       | `"AES_256_GCM"`       | no       |
| `encryption_key_algorithm`            | Assertion key transport algorithm                                      | `string`       | `"RSA-OAEP-11"`       | no       |
| `encryption_digest_method`            | Digest algorithm for assertion encryption                              | `string`       | `"SHA-256"`           | no       |
| `encryption_mask_generation_function` | Mask generation function for assertion encryption                      | `string`       | `"mgf1sha256"`        | no       |
| `encryption_certificate`              | Encryption certificate (auto-generated if null and encryption enabled) | `string`       | `null`                | no       |
| `signing_certificate`                 | Certificate for client signature verification                          | `string`       | `null`                | no       |
| `signing_private_key`                 | Private key for client signature verification                          | `string`       | `null`                | no       |
| `front_channel_logout`                | Enable browser redirect logout                                         | `bool`         | `true`                | no       |
| `logout_service_post_binding_url`     | SAML logout service POST URL                                           | `string`       | `null`                | no       |
| `logout_service_redirect_binding_url` | SAML logout service Redirect URL                                       | `string`       | `null`                | no       |
| `assertion_consumer_post_url`         | Assertion Consumer Service POST URL                                    | `string`       | `null`                | no       |
| `assertion_consumer_redirect_url`     | Assertion Consumer Service Redirect URL                                | `string`       | `null`                | no       |
| `default_scopes`                      | Default scopes assigned to the client                                  | `list(string)` | `null`                | no       |

> ⚠️ **Note:**
>
> - Required variables depend on the client type (`saml` or `openid-connect`).
> SAML-specific variables are automatically set to `null` when the client type is not `saml`.
> When `type = "saml"`, default values are applied automatically via `locals.tf`.
>
> - If `encrypt_assertions = true` and no encryption certificate was provided (`encryption_certificate = null`), a certificate will be generated automatically.

## Outputs

There are no outputs.

## Authors

Module is maintained by [Mohamed Amine Arous](https://github.com/maarous).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/maarous/opentofu-keycloak-client-module/tree/master/LICENSE) for full details.
