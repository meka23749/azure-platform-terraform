# Azure AI Platform – Terraform

Infrastructure as Code for a small, secure Azure platform that hosts a containerised API.
Built: remote state, private networking, secrets in Key Vault,
managed identities instead of passwords, cost control and a CI/CD pipeline with OIDC (no stored secrets).

## Architecture

```
                 Internet
                    │ HTTPS
          ┌─────────▼──────────┐
          │  Azure Container   │  user-assigned managed identity
          │  App (FastAPI)     │──────────────┐
          └─────────┬──────────┘              │ AcrPull / Key Vault Secrets User
                    │ snet-apps               │
 ┌──────────────────┼─────────────────────────┼──────────────┐
 │ VNet 10.20.0.0/16│                         │              │
 │                  │        snet-private-endpoints          │
 │                  │        ┌────────────────▼───┐          │
 │                  │        │ Private Endpoint   │          │
 │                  │        │  → Key Vault (RBAC)│          │
 │                  │        └────────────────────┘          │
 └──────────────────┴────────────────────────────────────────┘
        │                                   │
  Azure Container Registry           Log Analytics (KV audit logs)
  (Basic, no admin user)             Budget alerts (80 % / 100 %)

 Terraform state: Azure Storage (Entra ID auth, versioning, soft delete)
 CI: GitHub Actions (fmt + validate)   CD: Azure DevOps (validate → plan → approval → apply, OIDC)
```

## Repository layout

| Folder | Content |
|---|---|
| `bootstrap/` | One-time setup of the remote state backend (storage account + container) |
| `infra/` | Root module: resource group, module calls, budget |
| `infra/modules/network` | VNet, delegated subnet for Container Apps, private endpoint subnet, NSG |
| `infra/modules/monitoring` | Log Analytics workspace (30 days, 1 GB/day cap) |
| `infra/modules/keyvault` | Key Vault (RBAC), generated API secret, private endpoint + private DNS, diagnostics |
| `infra/modules/registry` | Azure Container Registry (admin user disabled) |
| `infra/modules/container_app` | Container Apps environment + app, managed identity, Key Vault secret reference |
| `app/` | Minimal FastAPI service (`/health`, `/secure`) + Dockerfile (non-root) |
| `pipelines/` | Azure DevOps pipeline (workload identity federation) |
| `.github/workflows/` | GitHub Actions: `terraform fmt` and `terraform validate` |
| `docs/screenshots/` | Screenshots from the Azure portal for each step |