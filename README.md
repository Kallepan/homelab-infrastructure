# 🏡 Homelab Repository

This repository documents the architecture and setup of my personal homelab environment, with a focus on infrastructure-as-code, high availability, and network segmentation.

---

## 🌐 Network Layout

### 🔧 VLANs & Subnets

| Segment Name     | Short Name | Description                                                     | VLAN ID | CIDRv4           | CIDRv6           |
|------------------|------------|-----------------------------------------------------------------|---------|------------------|------------------|
| `Infrastructure` | `INF`      | Core services: GitLab, ArgoCD, Vault, Observability, Keycloak   | 10      | 10.10.10.1/24    | fd00:10:10::/64  |
| `Services`       | `SVC`      | User-facing services: Home Assistant, Wiki.js                   | 20      | 10.10.20.1/24    | fd00:10:20::/64  |
| `Storage`        | `STO`      | Storage services (e.g., NFS, MinIO/S3)                          | 30      | 10.10.30.1/24    | fd00:10:30::/64  |
| `VPN`            | `VPN`      | VPN clients and management                                      | 100     | 10.10.100.1/24   | fd00:10:100::/64 |
| `DMZ`            | `DMZ`      | Public-facing services (e.g., VPN endpoint)                     | 1000      | 172.16.99.1/24   | fd00:16:99::/64  |

### 🧱 Reserved IP Ranges

- `10.100.0.0/24` — VPN Clients IP Range
- `10.233.0.0/16` — Kubernetes Cluster Pod CIDR

---

## 🌐 Internal DNS Domains

| Domain                  | Purpose                                  |
|-------------------------|------------------------------------------|
| `home.arpa`             | Root internal domain                     |
| `infra.home.arpa`       | Infrastructure services                  |
| `svc.home.arpa`         | Application services                     |
| `storage.home.arpa`     | Object and block storage endpoints       |
| `app.home.arpa`         | Docker and miscellaneous applications    |

---

## 🖥️ Virtual Machine Inventory

### 🔒 Network Gateway

| VM Name  | Description           | OS       | IP Address | RAM   |
|----------|-----------------------|----------|------------|-------|
| `router` | Firewall & router     | VyOS     | N/A        | 2GB   |

### ⚙️ Infrastructure Cluster (Talos-based)

| VM Name           | Role                    | IP Address    | RAM   |
|------------------|-------------------------|---------------|--------|
| `infra-control-1`| Control Plane Node 1     | 10.10.10.20   | 6GB    |
| `infra-control-2`| Control Plane Node 2     | 10.10.10.21   | 6GB    |
| `infra-control-3`| Control Plane Node 3     | 10.10.10.22   | 6GB    |
| `infra-worker-1` | Worker Node 1            | 10.10.10.30   | 16GB   |
| `infra-worker-2` | Worker Node 2            | 10.10.10.31   | 16GB   |
| `infra-worker-3` | Worker Node 3            | 10.10.10.32   | 16GB   |
| `rancher`        | Rancher Management UI    | 10.10.10.10   | 8GB    |

### 🧩 Services Cluster (RKE2-based)

| VM Name         | Role              | IP Address    | RAM    |
|-----------------|-------------------|---------------|--------|
| `svc-control-1` | Control Plane     | 10.10.20.20   | 6GB    |
| `svc-worker-1`  | Worker Node       | 10.10.20.30   | 6GB    |
| `docker`        | Standalone Docker | 10.10.20.10   | 6GB    |

### 💾 Storage & DMZ & VPN

| VM Name     | Description      | IP Address         | RAM      |
|-------------|------------------|--------------------|----------|
| `storage`   | S3/PSQL.         | 10.10.30.10        | 8GB      |
| `bastion`   | VPN Gateway      | 10.10.100.10       | 256MB    |
| `dmz`       | Public-facing services | 172.16.99.10 | 1GB      |

---

## 📌 Notes

- All Kubernetes clusters are configured using GitOps with FluxCD or ArgoCD.
- TLS is managed via an internal CA and certificates are issued for `*.home.arpa` subdomains.
- Internal DNS is managed using VyOS DNS features.
