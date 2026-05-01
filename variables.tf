# -----------------------------------------------------------------------
# 🟩 Common Client Variables 🟩
# -----------------------------------------------------------------------
variable "type" {
  description = "Type du client Keycloak"
  type        = string
  validation {
    condition     = contains(["saml", "openid-connect"], var.type)
    error_message = "The type must be either 'saml' or 'openid-connect'."
  }
}

variable "realm" {
  description = "Nom du realm"
  type        = string
}

variable "id" {
  description = "ID unique du client Keycloak"
  type        = string
}

variable "name" {
  description = "Nom du client Keycloak"
  type        = string
}

variable "description" {
  description = "Description du client Keycloak"
  type        = string
}

variable "login_theme" {
  description = "Thème de connexion du client OpenID Connect"
  type        = string
  default     = null
}

variable "root_url" {
  description = "URL racine du client"
  type        = string
}

variable "base_url" {
  description = "URL de base du client"
  type        = string
  default     = null
}

variable "valid_redirect_uris" {
  description = "Liste des URIs de redirection valides"
  type        = list(string)
  default     = null
}

variable "full_scope_allowed" {
  description = "Autoriser le scope complet"
  type        = bool
  default     = true
}

variable "consent_required" {
  description = "Consentement utilisateur requis pour OpenID Connect"
  type        = bool
  default     = false
}

variable "always_display_in_console" {
  description = "Toujours afficher le client dans la console"
  type        = bool
  default     = true
}

variable "authentication_browser_flow_override_name" {
  description = "Nom du flux d'authentification destiné à remplacer le flux par défaut"
  type        = string
  default     = null

  validation {
    condition     = var.authentication_browser_flow_override_name == null || length(var.authentication_browser_flow_override_name) > 0
    error_message = "authentication_browser_flow_override_name must be a non-empty string."
  }
}

variable "extra_config" {
  description = "Map des configurations supplémentaires du client OpenID Connect"
  type        = map(string)
  default     = {}
}

# -----------------------------------------------------------------------
# 🟧 Specific OpenID Connect Client Variables 🟧
# -----------------------------------------------------------------------
variable "access_type" {
  description = "Type d'accès du client OpenID Connect"
  type        = string
  default     = null

  validation {
    condition     = var.access_type == null || (var.type == "openid-connect" && contains(["PUBLIC", "CONFIDENTIAL"], var.access_type))
    error_message = "access_type applies only to OpenID Connect clients and must be one of: 'PUBLIC', 'CONFIDENTIAL'."
  }
}

variable "client_authenticator_type" {
  description = "Type d'authentificateur du client OpenID Connect"
  type        = string
  default     = null

  validation {
    condition = (
      var.client_authenticator_type == null ||
      (
        var.type == "openid-connect" &&
        contains(
          ["client-secret", "client-jwt", "client-x509", "client-secret-jwt"],
          var.client_authenticator_type
        ) &&
        var.access_type == "CONFIDENTIAL"
      )
    )
    error_message = "client_authenticator_type applies only to CONFIDENTIAL OpenID Connect clients and must be one of: 'client-secret', 'client-jwt', 'client-x509', or 'client-secret-jwt'."
  }
}

variable "standard_flow_enabled" {
  description = "Activer standard flow pour OpenID Connect"
  type        = bool
  default     = null
}

variable "service_accounts_enabled" {
  description = "Activer les comptes de service pour OpenID Connect"
  type        = bool
  default     = null

  validation {
    condition     = var.service_accounts_enabled == null || (var.type == "openid-connect" && (var.service_accounts_enabled == false || var.access_type == "CONFIDENTIAL"))
    error_message = "service_accounts_enabled applies only to OpenID Connect clients and requires access_type to be 'CONFIDENTIAL'."
  }
}

variable "standard_token_exchange_enabled" {
  description = "Activer l'échange de token standard"
  type        = bool
  default     = null

  validation {
    condition     = var.standard_token_exchange_enabled == null || (var.type == "openid-connect" && (var.standard_token_exchange_enabled == false || var.access_type == "CONFIDENTIAL"))
    error_message = "standard_token_exchange_enabled applies only to OpenID Connect clients."
  }
}

variable "oauth2_device_authorization_grant_enabled" {
  description = "Activer le flux d'autorisation pour les appareils OAuth2"
  type        = bool
  default     = null

  validation {
    condition     = var.oauth2_device_authorization_grant_enabled == null || var.type == "openid-connect"
    error_message = "oauth2_device_authorization_grant_enabled applies only to OpenID Connect clients."
  }
}

variable "web_origins" {
  description = "Liste des origines web autorisées"
  type        = list(string)
  default     = null

  validation {
    condition     = var.web_origins == null || (var.type == "openid-connect" && length(var.web_origins) >= 0)
    error_message = "web_origins applies only to OpenID Connect clients and must be defined."
  }
}

variable "admin_url" {
  description = "URL d'administration du client OpenID Connect"
  type        = string
  default     = null

  validation {
    condition     = var.admin_url == null || var.type == "openid-connect"
    error_message = "admin_url applies only to OpenID Connect clients."
  }
}

variable "exclude_session_state_from_auth_response" {
  description = "Exclure l'état de session de la réponse d'authentification"
  type        = bool
  default     = null

  validation {
    condition     = var.exclude_session_state_from_auth_response == null || var.type == "openid-connect"
    error_message = "exclude_session_state_from_auth_response applies only to OpenID Connect clients."
  }
}

variable "frontchannel_logout_enabled" {
  description = "Activer la déconnexion frontchannel"
  type        = bool
  default     = null

  validation {
    condition     = var.frontchannel_logout_enabled == null || var.type == "openid-connect"
    error_message = "frontchannel_logout_enabled applies only to OpenID Connect clients."
  }
}

variable "frontchannel_logout_url" {
  description = "URL de déconnexion frontchannel"
  type        = string
  default     = null

  validation {
    condition     = var.frontchannel_logout_url == null || var.type == "openid-connect"
    error_message = "frontchannel_logout_url applies only to OpenID Connect clients."
  }
}

variable "require_dpop_bound_tokens" {
  description = "Exiger des tokens liés DPoP"
  type        = bool
  default     = null

  validation {
    condition     = var.require_dpop_bound_tokens == null || var.type == "openid-connect"
    error_message = "require_dpop_bound_tokens applies only to OpenID Connect clients."
  }
}

variable "display_on_consent_screen" {
  description = "Afficher sur l'écran de consentement"
  type        = bool
  default     = null

  validation {
    condition     = var.display_on_consent_screen == null || (var.type == "openid-connect" && (var.display_on_consent_screen == false || var.consent_required))
    error_message = "display_on_consent_screen applies only to OpenID Connect clients and requires consent_required to be true."
  }
}

variable "consent_screen_text" {
  description = "Texte sur l'écran de consentement"
  type        = string
  default     = null

  validation {
    condition     = var.consent_screen_text == null || (var.type == "openid-connect" && var.display_on_consent_screen)
    error_message = "consent_screen_text applies only to OpenID Connect clients and requires display_on_consent_screen to be true."
  }
}

variable "exclude_issuer_from_auth_response" {
  description = "Exclure l'émetteur de la réponse d'authentification"
  type        = bool
  default     = null

  validation {
    condition     = var.exclude_issuer_from_auth_response == null || var.type == "openid-connect"
    error_message = "exclude_issuer_from_auth_response applies only to OpenID Connect clients."
  }
}

# -----------------------------------------------------------------------
# 🟪 Specific SAML Client Variables 🟪
# -----------------------------------------------------------------------
# General settings
variable "idp_initiated_sso_url_name" {
  description = "Fragment d'URL utilisé pour le SSO initié par l'IdP"
  type        = string
  default     = null

  validation {
    condition     = var.idp_initiated_sso_url_name == null || var.type == "saml"
    error_message = "idp_initiated_sso_url_name applies only to SAML clients."
  }
}

variable "idp_initiated_sso_relay_state" {
  description = "Valeur RelayState envoyée lors du SSO initié par l'IdP"
  type        = string
  default     = null

  validation {
    condition     = var.idp_initiated_sso_relay_state == null || var.type == "saml"
    error_message = "idp_initiated_sso_relay_state applies only to SAML clients."
  }
}

variable "master_saml_processing_url" {
  description = "URL principale pour traiter toutes les requêtes SAML"
  type        = string
  default     = null

  validation {
    condition     = var.master_saml_processing_url == null || var.type == "saml"
    error_message = "master_saml_processing_url applies only to SAML clients."
  }
}

# SAML capabilities
variable "name_id_format" {
  description = "Format du NameID utilisé dans l'assertion SAML"
  type        = string
  default     = null

  validation {
    condition = (
      var.name_id_format == null ||
      (
        var.type == "saml" &&
        contains([
          "username",
          "email",
          "persistent",
          "transient"
        ], var.name_id_format)
      )
    )
    error_message = "name_id_format applies only to SAML clients and must be one of: username, email, persistent, transient."
  }
}

variable "force_name_id_format" {
  description = "Ignore le format demandé et utilise celui configuré"
  type        = bool
  default     = null

  validation {
    condition     = var.force_name_id_format == null || var.type == "saml"
    error_message = "force_name_id_format applies only to SAML clients."
  }
}

variable "force_post_binding" {
  description = "Force l'utilisation du POST Binding SAML"
  type        = bool
  default     = null

  validation {
    condition     = var.force_post_binding == null || var.type == "saml"
    error_message = "force_post_binding applies only to SAML clients."
  }
}

variable "include_authn_statement" {
  description = "Ajoute un AuthnStatement dans la réponse SAML"
  type        = bool
  default     = null

  validation {
    condition     = var.include_authn_statement == null || var.type == "saml"
    error_message = "include_authn_statement applies only to SAML clients."
  }
}

# Signature and Encryption
variable "client_signature_required" {
  description = "Oblige les requêtes provenant du client à être signées"
  type        = bool
  default     = null

  validation {
    condition     = var.client_signature_required == null || var.type == "saml"
    error_message = "client_signature_required applies only to SAML clients."
  }
}

variable "sign_documents" {
  description = "Signe le document SAML avec la clé privée du realm"
  type        = bool
  default     = null

  validation {
    condition     = var.sign_documents == null || var.type == "saml"
    error_message = "sign_documents applies only to SAML clients."
  }
}

variable "sign_assertions" {
  description = "Signe les assertions SAML"
  type        = bool
  default     = null

  validation {
    condition = (
      var.sign_assertions == null ||
      (
        var.type == "saml" &&
        (var.sign_documents != false || var.sign_assertions)
      )
    )
    error_message = "sign_assertions applies only to SAML clients and must be enabled when sign_documents is disabled. At least one of the following options must be enabled: sign_assertions or sign_documents."
  }
}

variable "signature_algorithm" {
  description = "Algorithme utilisé pour signer les documents SAML"
  type        = string
  default     = null

  validation {
    condition = (
      var.signature_algorithm == null ||
      (
        var.type == "saml" &&
        contains([
          "RSA_SHA256",
          "RSA_SHA256_MGF1",
          "RSA_SHA512",
          "RSA_SHA512_MGF1"
        ], var.signature_algorithm)
      )
    )
    error_message = "signature_algorithm applies only to SAML clients and must be one of: RSA_SHA256, RSA_SHA256_MGF1, RSA_SHA512, RSA_SHA512_MGF1"
  }
}

variable "signature_key_name" {
  description = "Valeur utilisée dans l'élément KeyName du document signé"
  type        = string
  default     = null

  validation {
    condition = (
      var.signature_key_name == null ||
      (
        var.type == "saml" &&
        contains([
          "NONE",
          "KEY_ID",
          "CERT_SUBJECT"
        ], var.signature_key_name)
      )
    )
    error_message = "signature_key_name applies only to SAML clients and must be one of: NONE, KEY_ID, CERT_SUBJECT."
  }
}

variable "signing_certificate" {
  description = "Certificat utilisé pour vérifier les signatures du client"
  type        = string
  default     = null

  validation {
    condition     = var.signing_certificate == null || (var.type == "saml" && var.client_signature_required != false)
    error_message = "signing_certificate applies only to SAML clients and requires client_signature_required to be enabled."
  }
}

variable "signing_private_key" {
  description = "Clé privée utilisée pour vérifier les signatures du client"
  type        = string
  default     = null

  validation {
    condition     = var.signing_private_key == null || (var.type == "saml" && var.signing_certificate != null && var.client_signature_required != false)
    error_message = "signing_private_key applies only to SAML clients and requires client_signature_required to be enabled. It has to be provided if signing_certificate is provided."
  }
}

variable "canonicalization_method" {
  description = "Méthode de canonicalisation XML pour les signatures"
  type        = string
  default     = null

  validation {
    condition = (
      var.canonicalization_method == null ||
      (
        var.type == "saml" &&
        contains([
          "EXCLUSIVE",
          "EXCLUSIVE_WITH_COMMENTS",
          "INCLUSIVE",
          "INCLUSIVE_WITH_COMMENTS"
        ], var.canonicalization_method)
      )
    )
    error_message = "canonicalization_method applies only to SAML clients and must be one of: EXCLUSIVE, EXCLUSIVE_WITH_COMMENTS, INCLUSIVE, INCLUSIVE_WITH_COMMENTS."
  }
}

variable "encrypt_assertions" {
  description = "Chiffre les assertions SAML avec la clé publique du client"
  type        = bool
  default     = null

  validation {
    condition     = var.encrypt_assertions == null || var.type == "saml"
    error_message = "encrypt_assertions applies only to SAML clients."
  }
}

variable "encryption_algorithm" {
  description = "Algorithme de chiffrement des assertions SAML"
  type        = string
  default     = null

  validation {
    condition = (
      var.encryption_algorithm == null ||
      (
        var.type == "saml" &&
        var.encrypt_assertions &&
        contains([
          "AES_256_GCM",
          "AES_192_GCM",
          "AES_128_GCM"
        ], var.encryption_algorithm)
      )
    )
    error_message = "encryption_algorithm applies only to SAML clients. It must be one of: 'AES_256_GCM', 'AES_192_GCM', 'AES_128_GCM', and requires encrypt_assertions to be enabled."
  }
}

variable "encryption_key_algorithm" {
  description = "Algorithme de transport de la clé de chiffrement"
  type        = string
  default     = null

  validation {
    condition = (
      var.encryption_key_algorithm == null ||
      (
        var.type == "saml" &&
        var.encrypt_assertions &&
        contains([
          "RSA-OAEP-11",
          "RSA-OAEP-MGF1P",
          "RSA1_5"
        ], var.encryption_key_algorithm)
      )
    )
    error_message = "encryption_key_algorithm applies only to SAML clients. It must be one of: 'RSA-OAEP-11', 'RSA-OAEP-MGF1P', 'RSA1_5', and requires encrypt_assertions to be enabled."
  }
}

variable "encryption_digest_method" {
  description = "Méthode de digest utilisée pour le transport de clé de chiffrement"
  type        = string
  default     = null

  validation {
    condition = (
      var.encryption_digest_method == null ||
      (
        var.type == "saml" &&
        var.encrypt_assertions &&
        (
          var.encryption_key_algorithm == null ||
          var.encryption_key_algorithm == "RSA-OAEP-11" ||
          var.encryption_key_algorithm == "RSA-OAEP-MGF1P"
        ) &&
        contains([
          "SHA-512",
          "SHA-256"
        ], var.encryption_digest_method)
      )
    )
    error_message = "encryption_digest_method applies only to SAML clients and must be one of: SHA-512, SHA-256. It requires encrypt_assertions to be enabled and encryption_key_algorithm to be null, RSA-OAEP-11, or RSA-OAEP-MGF1P."
  }
}

variable "encryption_mask_generation_function" {
  description = "Fonction MGF utilisée pour le chiffrement"
  type        = string
  default     = null

  validation {
    condition = (
      var.encryption_mask_generation_function == null ||
      (
        var.type == "saml" &&
        var.encrypt_assertions &&
        (
          var.encryption_key_algorithm == null ||
          var.encryption_key_algorithm == "RSA-OAEP-11"
        ) &&
        contains([
          "mgf1sha224",
          "mgf1sha256",
          "mgf1sha384",
          "mgf1sha512"
        ], var.encryption_mask_generation_function)
      )
    )
    error_message = "encryption_mask_generation_function applies only to SAML clients and must be one of: mgf1sha224, mgf1sha256, mgf1sha384, mgf1sha512. It requires encrypt_assertions to be enabled and encryption_key_algorithm to be null or RSA-OAEP-11."
  }
}



variable "encryption_certificate" {
  description = "Certificat utilisé pour chiffrer les assertions"
  type        = string
  default     = null

  validation {
    condition     = var.encryption_certificate == null || (var.type == "saml" && var.encrypt_assertions) # if encrypt_assertions is true and encryption_certificate == null, a certificate will be generated automatically
    error_message = "encryption_certificate applies only to SAML clients and requires encrypt_assertions to be true."
  }
}

# Logout settings
variable "front_channel_logout" {
  description = "Active le logout via redirection navigateur"
  type        = bool
  default     = null

  validation {
    condition     = var.front_channel_logout == null || var.type == "saml"
    error_message = "front_channel_logout applies only to SAML clients."
  }
}

# Fine Grain SAML Endpoint Configuration
variable "assertion_consumer_post_url" {
  description = "URL ACS utilisant POST binding"
  type        = string
  default     = null

  validation {
    condition     = var.assertion_consumer_post_url == null || var.type == "saml"
    error_message = "assertion_consumer_post_url applies only to SAML clients."
  }
}

variable "assertion_consumer_redirect_url" {
  description = "URL ACS utilisant Redirect binding"
  type        = string
  default     = null

  validation {
    condition     = var.assertion_consumer_redirect_url == null || var.type == "saml"
    error_message = "assertion_consumer_redirect_url applies only to SAML clients."
  }
}

variable "logout_service_post_binding_url" {
  description = "URL de logout SAML utilisant POST binding"
  type        = string
  default     = null

  validation {
    condition     = var.logout_service_post_binding_url == null || var.type == "saml"
    error_message = "logout_service_post_binding_url applies only to SAML clients."
  }
}

variable "logout_service_redirect_binding_url" {
  description = "URL de logout SAML utilisant Redirect binding"
  type        = string
  default     = null

  validation {
    condition     = var.logout_service_redirect_binding_url == null || var.type == "saml"
    error_message = "logout_service_redirect_binding_url applies only to SAML clients."
  }
}

variable "default_scopes" {
  description = "Liste des scopes par défaut pour le cliennt (applicable aux clients OpenID Connect et SAML)"
  type        = list(string)
  default     = null
}
