# Manage auth backends broadly across Vault
path "auth/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List, create, update, and delete auth backends
path "sys/auth/*" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

# Create and manage ACL policies broadly across Vault
path "sys/policies/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage database config
path "database/config/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage database role
path "database/roles/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List, create, update, and delete key/value secrets
path "secret/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
path "kv/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage and manage secret backends broadly across Vault.
path "sys/mounts/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Read health checks
path "sys/health" {
  capabilities = ["read", "sudo"]
}
