## Configure Vault

This guide will walk you through configure Vault policies and user to secure your secrets.

Login to Vault with `root` token:
```bash
$ export VAULT_ADDR=http[s]//<vault-address>:<vault-port>
$ vault login
Token (will be hidden): <enter root token here>
```
* Create admin policy:
```bash
vault policy write admin admin.hcl
```
* Enable auth methods
```bash
vault auth enable userpass
vault auth enable approle
```
* Create user accsociated with policy `admin`
```bash
vault write auth/userpass/users/nthienan \
  password=123456 \
  policies="admin" \
  metadata=Description="admin user"
```
There is a recommended (a best practice) that `root` token should not be used for any Vault operations except initialize operations. After that `root` token should be revoked and cannot be used anymore.

Login as `nthienan` user:
```bash
$ vault login -method=userpass username=nthienan
Password (will be hidden): <type nthienan's password>
```
AppRole is a secure introduction method to establish machine identity. In AppRole, in order for the application to get a token, it would need to login using a Role ID (which is static, and associated with a policy), and a Secret ID (which is dynamic, one time use, and can only be requested by a previously authenticated user/system.
