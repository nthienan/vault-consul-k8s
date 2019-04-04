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
Create an internal group named `admin`
```bash
vault write identity/group name="admin" \
  policies="admin" \
  metadata=Description="Admin group"
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
Note that in this case, the tokens generated through this policy have a time-to-live of 15 minutes. That means that after 15 minutes, that token is expired and can’t be used anymore. If you’re Jenkins jobs are shorted, you can adjust that time to live now to increase security.

```bash
vault kv put kv/team-a/mongodb username=mongo_root password=123456
```
