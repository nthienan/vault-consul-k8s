Create policies
```bash
vault policy write admin admin.hcl
vault policy write team-a-readonly team-a-readonly.hcl
vault policy write team-a-admin team-a-admin.hcl
```
Enable auth methods
```bash
vault auth enable userpass
vault auth enable approle
```
Create user
```bash
vault write auth/userpass/users/nthienan \
  password=123456 \
  policies="admin" \
  metadata=Description="admin user"
```
Login as `nthienan` user:
```bash
$ vault login -method=userpass username=nthienan
Password (will be hidden): <type admin's password>
```
Now we have to create a Role that will generate tokens associated with that policy, and retrieve the token:
```bash
vault write auth/approle/role/team-a \
	secret_id_ttl=60m \
	token_ttl=15m \
	token_max_ttl=120m \
	policies="team-a-readonly"
```
```bash
$ vault read auth/approle/role/team-a/role-id
Key        Value
---        -----
role_id    84092a58-fcfb-ea53-a13e-628bd43bc966
```
Note that in this case, the tokens generated through this policy have a time-to-live of 15 minutes. That means that after 15 minutes, that token is expired and can’t be used anymore. If you’r Jenkins jobs are shorted, you can adjust that time to live to increase security.

```bash
vault kv put kv/team-a/mongodb username=mongo_root password=123456
```
Now Jenkins will need permissions to retrieve Secret IDs for our newly created role. Jenkins shouldn’t be able to access the secret itself, list other Secret IDs, or even the Role ID.
```bash
vault policy write jenkins jenkins.hcl
```
And generate a token for Jenkins to login into Vault. This token should have a relatively large TTL, but will have to be rotated
```bash
vault token create -policy=jenkins -ttl=24h
```
