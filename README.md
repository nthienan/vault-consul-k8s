# Secret Management solution with Hashicorp Vault and Consul on Kubernetes
The credential store in most enterprises is becoming a potential attack vector. It’s generally filled with long lived credentials, sometimes even to production systems.   
In comes Hashicorp’s Vault, a solution that enables the secure store of secrets, and dynamic generation of credentials for your job. It certaintly looks promising.

### Deployment topology
Vault supports a multi-server mode for high availability. This mode protects against outages by running multiple Vault servers. High availability mode is automatically enabled when using a data store that supports it.  

![Deployment topology](docs/images/deployment-topology.jpg "Deployment topology")

In this deployment, Consul pods function is to serve as the storage backend for Vault. This means that all content stored for persistence in Vault is encrypted by Vault, and written to the storage backend at rest.

Please refer [consul/README.md](consul/README.md) for deploying Consul cluster and [vault/README.md](vault/README.md) for deploying Vault cluster on Kubernetes.   
In additional, you can refer [Vault Reference Architecture](https://learn.hashicorp.com/vault/operations/ops-reference-architecture) for more details.

### Demo
- [Scenario 1: Legacy applications that don’t run on Kubernetes](https://github.com/nthienan/ci-sample/tree/scenario-1)
- [Scenario 2: Applications that run on Kubernetes](https://github.com/nthienan/ci-sample/tree/scenario-2)
- [Scenario 3: New applications that use static credentials](https://github.com/nthienan/ci-sample/tree/scenario-3)
- [Scenario 4: New applications that use dynamic credentials](https://github.com/nthienan/ci-sample/tree/scenario-4)
