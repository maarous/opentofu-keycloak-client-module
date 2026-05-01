# Exemple : client SAML
module "client" {
  source = "../../"

  realm       = "my-realm"
  type        = "saml"
  id          = "https://myapp.example.com"
  name        = "my-saml-client"
  description = "SAML client example"
  root_url    = "https://myapp.example.com"

  master_saml_processing_url = "https://myapp.example.com/saml"

  name_id_format       = "email"
  force_name_id_format = true

  sign_assertions          = true
  signature_algorithm      = "RSA_SHA256"
  signature_key_name       = "KEY_ID"
  canonicalization_method  = "EXCLUSIVE"
  encrypt_assertions       = true
  encryption_algorithm     = "AES_256_GCM"
  encryption_key_algorithm = "RSA-OAEP-11"
}
