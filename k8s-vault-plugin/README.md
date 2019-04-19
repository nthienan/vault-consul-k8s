## Deploy kubernetes-vault

### Configure Vault

- Set up the Root Certificate Authority
  * Create a Root CA that expires in 10 years:
    ```bash
    $ vault secrets enable -path=root-ca -max-lease-ttl=87600h pki
    Success! Enabled the pki secrets engine at: root-ca/
    ```
  * Generate the root certificate:
    ```bash
    $ vault write root-ca/root/generate/internal common_name="Root CA" ttl=87600h exclude_cn_from_sans=true
    Key              Value
    ---              -----
    certificate      -----BEGIN CERTIFICATE-----
    MIIDFTCCAf2gAwIBAgIURPvUW1dgz09BjsSKyX47LuFmuvMwDQYJKoZIhvcNAQEL
    BQAwEjEQMA4GA1UEAxMHUm9vdCBDQTAeFw0xOTA0MTkwMjU5MjZaFw0yOTA0MTYw
    MjU5NTVaMBIxEDAOBgNVBAMTB1Jvb3QgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IB
    DwAwggEKAoIBAQDvXlsdeZYEn9zZ/IK8TU15INClZSqKA3LmcuqVtht0WHQV1xue
    htCf4Hp3bsBMKG/XPqdAGCNoPWCF6qNEgwsDa1vzqZlg1icmn1cQ6Tm6XrkOS68x
    7iAwO6Npsr0do5EDlnpEHfrZ+eYWkgU9mv+a78mBDb2FarhmyCgwhnqi0iLcVDTG
    somZTnL/16hMtFZy4Wog8Z51B88VHXQbTkLsf5s6aBl8NkBu2aFsJb8BigzxnOfo
    3l5zuEDmntoPlslI2GMCvQzt2WDMkx7H8C9MMCNCrxnl0wA0HMITaRDJL+VgbCJf
    WSCPDGVGQLHTH4r06513dO2sJgHmGM+Lh2PVAgMBAAGjYzBhMA4GA1UdDwEB/wQE
    AwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBT7L/U6cvLh7NvK/kJ6DzTl
    SX3leTAfBgNVHSMEGDAWgBT7L/U6cvLh7NvK/kJ6DzTlSX3leTANBgkqhkiG9w0B
    AQsFAAOCAQEA2Vx44Bz12BchPS+EWU6JA1WWM1v/TnILOMQYnT+3nkeWy5IjgwGf
    ZI3adMU54WTH7XfR85c3vmEPfR7zyWx3DDyAGn8CRLt655wSdVh92eUGYvV1/rKS
    K+TTqr1o6mAWTYtkx6NQxYUBgLWv8ceuVtJmS4075GxIPkVO8XMVErL/+IGvHkev
    PsRAvNWvE7kJGeJBihWqZ6//+SSjNzrSKvQQ7AaUJ0pMW6CBdRZrIL52zQtFG/53
    133no9+1sacpBbI8jMO5Po8vuYiOcJVnYP0CubF4VgX3Qtc6I6ovGr9KPFuE6btE
    WpCaohxdLVLpUZpvCyk4D+GTpl2e9yjeDg==
    -----END CERTIFICATE-----
    expiration       1871002795
    issuing_ca       -----BEGIN CERTIFICATE-----
    MIIDFTCCAf2gAwIBAgIURPvUW1dgz09BjsSKyX47LuFmuvMwDQYJKoZIhvcNAQEL
    BQAwEjEQMA4GA1UEAxMHUm9vdCBDQTAeFw0xOTA0MTkwMjU5MjZaFw0yOTA0MTYw
    MjU5NTVaMBIxEDAOBgNVBAMTB1Jvb3QgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IB
    DwAwggEKAoIBAQDvXlsdeZYEn9zZ/IK8TU15INClZSqKA3LmcuqVtht0WHQV1xue
    htCf4Hp3bsBMKG/XPqdAGCNoPWCF6qNEgwsDa1vzqZlg1icmn1cQ6Tm6XrkOS68x
    7iAwO6Npsr0do5EDlnpEHfrZ+eYWkgU9mv+a78mBDb2FarhmyCgwhnqi0iLcVDTG
    somZTnL/16hMtFZy4Wog8Z51B88VHXQbTkLsf5s6aBl8NkBu2aFsJb8BigzxnOfo
    3l5zuEDmntoPlslI2GMCvQzt2WDMkx7H8C9MMCNCrxnl0wA0HMITaRDJL+VgbCJf
    WSCPDGVGQLHTH4r06513dO2sJgHmGM+Lh2PVAgMBAAGjYzBhMA4GA1UdDwEB/wQE
    AwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBT7L/U6cvLh7NvK/kJ6DzTl
    SX3leTAfBgNVHSMEGDAWgBT7L/U6cvLh7NvK/kJ6DzTlSX3leTANBgkqhkiG9w0B
    AQsFAAOCAQEA2Vx44Bz12BchPS+EWU6JA1WWM1v/TnILOMQYnT+3nkeWy5IjgwGf
    ZI3adMU54WTH7XfR85c3vmEPfR7zyWx3DDyAGn8CRLt655wSdVh92eUGYvV1/rKS
    K+TTqr1o6mAWTYtkx6NQxYUBgLWv8ceuVtJmS4075GxIPkVO8XMVErL/+IGvHkev
    PsRAvNWvE7kJGeJBihWqZ6//+SSjNzrSKvQQ7AaUJ0pMW6CBdRZrIL52zQtFG/53
    133no9+1sacpBbI8jMO5Po8vuYiOcJVnYP0CubF4VgX3Qtc6I6ovGr9KPFuE6btE
    WpCaohxdLVLpUZpvCyk4D+GTpl2e9yjeDg==
    -----END CERTIFICATE-----
    serial_number    44:fb:d4:5b:57:60:cf:4f:41:8e:c4:8a:c9:7e:3b:2e:e1:66:ba:f3
    ```
  * Set up the URLs:
    ```bash
    $ vault write root-ca/config/urls issuing_certificates="http://vault.nthienan.com/v1/root-ca/ca" \
        crl_distribution_points="http://vault.nthienan.com/v1/root-ca/crl"
    Success! Data written to: root-ca/config/urls
    ```
- Create the Intermediate Certificate Authority
  * Create the Intermediate CA that expires in 5 years:
    ```bash
    $ vault secrets enable -path=intermediate-ca -max-lease-ttl=43800h pki
    Success! Enabled the pki secrets engine at: intermediate-ca/
    ```
  * Generate a certificate signing request:
    ```bash
    $ vault write intermediate-ca/intermediate/generate/internal \
        common_name="Intermediate CA" ttl=43800h exclude_cn_from_sans=true
    Key    Value
    ---    -----
    csr    -----BEGIN CERTIFICATE REQUEST-----
    MIICXzCCAUcCAQAwGjEYMBYGA1UEAxMPSW50ZXJtZWRpYXRlIENBMIIBIjANBgkq
    hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA49Ci1HEtx/+vmxOjUOHD4cHfwwpBOeQO
    umnGEw3nBD4o9/7uT/MZe9AsIMHIh9Vw9S2GIFFI6ve80Lzg8+pmX1JsNSa/8pqR
    uZUetVUFfL552qWcawH7brR2HEzGrXgqxLHkSXZFJw6PlM91Tu7RQP08j5Q8/ueT
    7DAKeYwmFLGuxbpGQ71dHo0zXJBC7hk4Uab0UwPGFKMMBBlHi6w/kwG9vYp1CJqc
    YZEwBsY2eInNcp4n8YaD3ZodnEo1vP6EgoCI7rgtJBO3XFAQ+MzZSu3ZFmQoDEZa
    yz9Rj73qLoQfDFbBiMauuFa5hbQc5P7eAIGv8/vzr6sJpiO1fPWy+wIDAQABoAAw
    DQYJKoZIhvcNAQELBQADggEBAGMp7xfpGtSKu56/BZ2dcgEQTG8qmG97LDps8eww
    OXKfSTRdSSKOmlbZIYBtTiXBBasvSHi/TiQXrJGCWn8i/XE2fA4DmRYnpm/bOk6c
    ZFX5s6KpX6WuM/Emywf/C03DL+kWdf/91w4g0Z1c32Rti4GaSkWi07xa0ytotlCI
    Vc/HKWkw68KUOox/1IV6vcg978DdWl5mjreS/xjfw9ZORvx/QLHZ158ek5n7WigC
    SK+uPmlv29eEnd01/p2J6LbkS+saw7uQ009Ll/wI59aMsMzm/3V0pcgesye5sc6F
    yz+lOmoIBb2VqfvsWi8Bi8FRnbD8Ut6RD8h69g0LehixcDU=
    -----END CERTIFICATE REQUEST-----
    ```
    Copy the CSR (starting from -----BEGIN CERTIFICATE REQUEST----- until the end of -----END CERTIFICATE REQUEST----- from the output above) to a file called `intermediate.csr`.
  * Ask the Root to sign it:
    ```bash
    $ vault write root-ca/root/sign-intermediate \
        csr=@intermediate.csr use_csr_values=true exclude_cn_from_sans=true
    Key              Value
    ---              -----
    certificate      -----BEGIN CERTIFICATE-----
    MIIDnzCCAoegAwIBAgIUbk738W7jUFU/+FF23L5wiiZMlVAwDQYJKoZIhvcNAQEL
    BQAwEjEQMA4GA1UEAxMHUm9vdCBDQTAeFw0xOTA0MTkwMzE1NTBaFw0xOTA1MjEw
    MzE2MjBaMBoxGDAWBgNVBAMTD0ludGVybWVkaWF0ZSBDQTCCASIwDQYJKoZIhvcN
    AQEBBQADggEPADCCAQoCggEBAOPQotRxLcf/r5sTo1Dhw+HB38MKQTnkDrppxhMN
    5wQ+KPf+7k/zGXvQLCDByIfVcPUthiBRSOr3vNC84PPqZl9SbDUmv/KakbmVHrVV
    BXy+edqlnGsB+260dhxMxq14KsSx5El2RScOj5TPdU7u0UD9PI+UPP7nk+wwCnmM
    JhSxrsW6RkO9XR6NM1yQQu4ZOFGm9FMDxhSjDAQZR4usP5MBvb2KdQianGGRMAbG
    NniJzXKeJ/GGg92aHZxKNbz+hIKAiO64LSQTt1xQEPjM2Urt2RZkKAxGWss/UY+9
    6i6EHwxWwYjGrrhWuYW0HOT+3gCBr/P786+rCaYjtXz1svsCAwEAAaOB5DCB4TAO
    BgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUUl11i3CS
    fM3a8nOFli4kNFkmdSswHwYDVR0jBBgwFoAU+y/1OnLy4ezbyv5Ceg805Ul95Xkw
    QwYIKwYBBQUHAQEENzA1MDMGCCsGAQUFBzAChidodHRwOi8vdmF1bHQubnRoaWVu
    YW4uY29tL3YxL3Jvb3QtY2EvY2EwOQYDVR0fBDIwMDAuoCygKoYoaHR0cDovL3Zh
    dWx0Lm50aGllbmFuLmNvbS92MS9yb290LWNhL2NybDANBgkqhkiG9w0BAQsFAAOC
    AQEAuhrr8Hi9fniCw2j5g4Yz56q9hfQlhMAJxSvdVPIvZJaQXG7bUuPOwOobTsv7
    EdlQcein+cQ7sn5WPVfQ/SzxqBTZO77jY5mGc2ZlipT1jVLgcQv2XUxfD8okwjqq
    Y6w1JdOGUQN95XFQo045ijqD6CGHxlicJj1GGp7TPl/E+9FMLmedd7RqhatJ41QK
    mLG4UJRi/mfWIeYO9rliRz32O/vCLNR1rzfYm62MtnJW3Ut6o9sf5XXtHZ2Y56gO
    DzTGxiDySSrWPm+0YLByMQm9X83abjPn78bSRAyvBWjbRPsEGTbfSRjUKsOnnhfW
    BBUWHFSb0sIiNnXTQ0RdTD2Ngg==
    -----END CERTIFICATE-----
    expiration       1558408580
    issuing_ca       -----BEGIN CERTIFICATE-----
    MIIDFTCCAf2gAwIBAgIURPvUW1dgz09BjsSKyX47LuFmuvMwDQYJKoZIhvcNAQEL
    BQAwEjEQMA4GA1UEAxMHUm9vdCBDQTAeFw0xOTA0MTkwMjU5MjZaFw0yOTA0MTYw
    MjU5NTVaMBIxEDAOBgNVBAMTB1Jvb3QgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IB
    DwAwggEKAoIBAQDvXlsdeZYEn9zZ/IK8TU15INClZSqKA3LmcuqVtht0WHQV1xue
    htCf4Hp3bsBMKG/XPqdAGCNoPWCF6qNEgwsDa1vzqZlg1icmn1cQ6Tm6XrkOS68x
    7iAwO6Npsr0do5EDlnpEHfrZ+eYWkgU9mv+a78mBDb2FarhmyCgwhnqi0iLcVDTG
    somZTnL/16hMtFZy4Wog8Z51B88VHXQbTkLsf5s6aBl8NkBu2aFsJb8BigzxnOfo
    3l5zuEDmntoPlslI2GMCvQzt2WDMkx7H8C9MMCNCrxnl0wA0HMITaRDJL+VgbCJf
    WSCPDGVGQLHTH4r06513dO2sJgHmGM+Lh2PVAgMBAAGjYzBhMA4GA1UdDwEB/wQE
    AwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBT7L/U6cvLh7NvK/kJ6DzTl
    SX3leTAfBgNVHSMEGDAWgBT7L/U6cvLh7NvK/kJ6DzTlSX3leTANBgkqhkiG9w0B
    AQsFAAOCAQEA2Vx44Bz12BchPS+EWU6JA1WWM1v/TnILOMQYnT+3nkeWy5IjgwGf
    ZI3adMU54WTH7XfR85c3vmEPfR7zyWx3DDyAGn8CRLt655wSdVh92eUGYvV1/rKS
    K+TTqr1o6mAWTYtkx6NQxYUBgLWv8ceuVtJmS4075GxIPkVO8XMVErL/+IGvHkev
    PsRAvNWvE7kJGeJBihWqZ6//+SSjNzrSKvQQ7AaUJ0pMW6CBdRZrIL52zQtFG/53
    133no9+1sacpBbI8jMO5Po8vuYiOcJVnYP0CubF4VgX3Qtc6I6ovGr9KPFuE6btE
    WpCaohxdLVLpUZpvCyk4D+GTpl2e9yjeDg==
    -----END CERTIFICATE-----
    serial_number    6e:4e:f7:f1:6e:e3:50:55:3f:f8:51:76:dc:be:70:8a:26:4c:95:50
    ```
  Copy the certificate (under the certificate key in the above output, from -----BEGIN CERTIFICATE----- until the end of -----END CERTIFICATE-----) to `signed.crt`.
  * Send the stored certificate back to Vault:
    ```bash
    $ vault write intermediate-ca/intermediate/set-signed certificate=@signed.crt
    Success! Data written to: intermediate-ca/intermediate/set-signed
    ```
  * Set up URLs::
    ```bash
    $ vault write intermediate-ca/config/urls issuing_certificates="http://vault.nthienan.com/v1/intermediate-ca/ca" \
        crl_distribution_points="http://vault.nthienan.com/v1/intermediate-ca/crl"
    Success! Data written to: intermediate-ca/config/urls
    ```
- Enable auth approle if it's not already enabled yet:
  ```bash
  $ vault auth enable approle
  ```
- Create roles and policies for kubernetes-vault:
  * Create a role to allow kubernetes-vault to generate certificates:
    ```bash
    $ vault write intermediate-ca/roles/kubernetes-vault allow_any_name=true max_ttl="24h"
    Success! Data written to: intermediate-ca/roles/kubernetes-vault
    ```
  * Create policy `kubernetes-vault`:
    ```bash
    $ echo 'path "intermediate-ca/issue/kubernetes-vault" {
      capabilities = ["update"]
    }
    path "auth/token/roles/kubernetes-vault" {
      capabilities = ["read"]
    }' | vault policy write kubernetes-vault -
    Success! Uploaded policy: kubernetes-vault
    ```
  * Create a token role for Kubernetes-Vault that generates a 6 hour periodic token:
    ```bash
    $ vault write auth/token/roles/kubernetes-vault allowed_policies=kubernetes-vault period=6h
    Success! Data written to: auth/token/roles/kubernetes-vault
    ```
- Generate the token for kubernetes-vault
  ```bash
  $ vault token create -role=kubernetes-vault
  Key                  Value
  ---                  -----
  token                s.o8WfFFCHPu5tD8HIB2bQ6TtL
  token_accessor       grdEUljqThFxYE1JX7RU4qMZ
  token_duration       6h
  token_renewable      true
  token_policies       ["default" "kubernetes-vault"]
  identity_policies    []
  policies             ["default" "kubernetes-vault"]
  ```
- Deploy kubernetes-vault:
  * Check `kubernetes-vault.yaml` and update the Vault token in the Kubernetes deployment.
    ```yaml
    ...
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: kubernetes-vault
    data:
      kubernetes-vault.yml: |-
        vault:
          addr: http://vault.nthienan.com
          token: s.o8WfFFCHPu5tD8HIB2bQ6TtL
    ...
    ```
  Make sure you modify the namespaces in the RBAC objects if you are not using the `default` namespace.   
  * Deploy kubernetes-vault:
    ```bash
    $ kubectl apply -f kubernetes-vault.yaml
    ```
  * Confirm kubernetes-vault deployed successfully:
    ```bash
    $ kubectl get pod
    NAME                               READY   STATUS    RESTARTS   AGE
    kubernetes-vault-8997d96bd-5clfn   1/1     Running   0          9m55s
    kubernetes-vault-8997d96bd-9q8tp   1/1     Running   0          9m55s
    kubernetes-vault-8997d96bd-z49sf   1/1     Running   0          9m55s
    $ kubectl logs -f kubernetes-vault-8997d96bd-5clfn
    time="2019-04-19T03:51:56Z" level=debug msg="2019/04/19 03:51:56 [DEBUG] raft: Vote granted from 10.60.2.15:45679. Tally: 2"
    time="2019-04-19T03:51:56Z" level=debug msg="2019/04/19 03:51:56 [INFO] raft: Election won. Tally: 2"
    time="2019-04-19T03:51:56Z" level=debug msg="2019/04/19 03:51:56 [INFO] raft: Node at 10.60.4.15:45679 [Leader] entering Leader state"
    ```
