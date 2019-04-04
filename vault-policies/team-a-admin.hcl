
# If working with kv version 2
path "secret/data/team-a" {
  capabilities = [ "create", "read", "update", "delete"]
}
path "kv/data/team-a/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# If working with kv version 1
path "secret/team-a" {
  capabilities = [ "create", "read", "update", "delete"]
}
path "kv/team-a/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
