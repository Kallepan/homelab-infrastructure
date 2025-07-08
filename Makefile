# ===========================
#   Ansible Variables
# ===========================

# Minio Credentials
export MINIO_ROOT_USER := $(shell sops -d secrets.yaml | yq .minio.root_user -r)
export MINIO_ROOT_PASSWORD := $(shell sops -d secrets.yaml | yq .minio.root_password -r)

# PostgreSQL Credentials
export POSTGRESQL_PASSWORD ?= $(shell sops -d secrets.yaml | yq .postgresql.password -r)
export POSTGRES_EXPORTER_PASSWORD ?= $(shell sops -d secrets.yaml | yq .postgresql.exporter.password -r)
export POSTGRESQL_AWS_ACCESS_KEY_ID ?= $(shell sops -d secrets.yaml | yq .minio.buckets.backups.access_key -r)
export POSTGRESQL_AWS_SECRET_ACCESS_KEY ?= $(shell sops -d secrets.yaml | yq .minio.buckets.backups.secret_key -r)

SECRETS_FILE        ?= secrets.yaml
INVENTORY           ?= inventory/hosts.yml
PLAYBOOK            ?= playbooks/homelab.yml

export PUBLIC_KEY := $(shell sops -d secrets.yaml | yq .public_key -r)

# ===========================
#   Terraform Variables
# ===========================

BASE_DIR ?= $(shell pwd)
KUBECONFIG ?= ${BASE_DIR}/templates/talos/infrastructure/configs/kubeconfig
export TF_VAR_kubernetes_config_path := $(KUBECONFIG)
export TF_VAR_cert_manager_ca_crt_path ?= $(BASE_DIR)/pki/intermediate-ca-2/intermediate-ca-2-chain.pem
export TF_VAR_cert_manager_ca_key_path ?= $(BASE_DIR)/pki/intermediate-ca-2/private/intermediate-ca-2.key
export TF_VAR_minio_user ?= $(MINIO_ROOT_USER)
export TF_VAR_minio_password ?= $(MINIO_ROOT_PASSWORD)

export TF_VAR_bucket_argo_access_key ?= $(shell sops -d secrets.yaml | yq .minio.buckets.argo.access_key -r)
export TF_VAR_bucket_argo_secret_key ?= $(shell sops -d secrets.yaml | yq .minio.buckets.argo.secret_key -r)

export TF_VAR_bucket_backups_access_key ?= $(shell sops -d secrets.yaml | yq .minio.buckets.backups.access_key -r)
export TF_VAR_bucket_backups_secret_key ?= $(shell sops -d secrets.yaml | yq .minio.buckets.backups.secret_key -r)

export TF_VAR_bucket_gitlab_access_key ?= $(shell sops -d secrets.yaml | yq .minio.buckets.gitlab.access_key -r)
export TF_VAR_bucket_gitlab_secret_key ?= $(shell sops -d secrets.yaml | yq .minio.buckets.gitlab.secret_key -r)

export TF_VAR_bucket_gitlab_runner_access_key ?= $(shell sops -d secrets.yaml | yq .minio.buckets.gitlab_runner.access_key -r)
export TF_VAR_bucket_gitlab_runner_secret_key ?= $(shell sops -d secrets.yaml | yq .minio.buckets.gitlab_runner.secret_key -r)

export TF_VAR_bucket_loki_access_key ?= $(shell sops -d secrets.yaml | yq .minio.buckets.loki.access_key -r)
export TF_VAR_bucket_loki_secret_key ?= $(shell sops -d secrets.yaml | yq .minio.buckets.loki.secret_key -r)

export TF_VAR_bucket_rancher_access_key ?= $(shell sops -d secrets.yaml | yq .minio.buckets.rancher.access_key -r)
export TF_VAR_bucket_rancher_secret_key ?= $(shell sops -d secrets.yaml | yq .minio.buckets.rancher.secret_key -r)

export TF_VAR_postgres_username ?= postgres
export TF_VAR_postgres_password ?= $(POSTGRESQL_PASSWORD)

export TF_VAR_grafana_oauth_client_secret ?= $(shell sops -d secrets.yaml | yq .grafana.oauth_client_secret -r)
export TF_VAR_grafana_oauth_client_id ?= $(shell sops -d secrets.yaml | yq .grafana.oauth_client_id -r)

export TF_VAR_argo_oauth_client_id ?= $(shell sops -d secrets.yaml | yq .argo.oauth_client_id -r)
export TF_VAR_argo_oauth_client_secret ?= $(shell sops -d secrets.yaml | yq .argo.oauth_client_secret -r)

export TF_VAR_alertmanager_mattermost_webhook_url ?= $(shell sops -d secrets.yaml | yq .alertmanager.mattermost_webhook_url -r)

export TF_VAR_gitlab_oauth_client_id ?= $(shell sops -d secrets.yaml | yq .gitlab.oauth_client_id -r)
export TF_VAR_gitlab_oauth_client_secret ?= $(shell sops -d secrets.yaml | yq .gitlab.oauth_client_secret -r)
export TF_VAR_gitlab_postgres_username ?= $(shell sops -d secrets.yaml | yq .gitlab.db.username -r)
export TF_VAR_gitlab_postgres_password ?= $(shell sops -d secrets.yaml | yq .gitlab.db.password -r)
export TF_VAR_gitlab_registry_postgres_username ?= $(shell sops -d secrets.yaml | yq .gitlab.registry_db.username -r)
export TF_VAR_gitlab_registry_postgres_password ?= $(shell sops -d secrets.yaml | yq .gitlab.registry_db.password -r)
export TF_VAR_gitlab_runner_token ?= $(shell sops -d secrets.yaml | yq .gitlab.runner_token -r)

export TF_VAR_mattermost_database_connection_string ?= $(shell sops -d secrets.yaml | yq .mattermost.database_connection_string -r)

export TF_VAR_keycloak_postgres_username ?= $(shell sops -d secrets.yaml | yq .keycloak.db.username -r)
export TF_VAR_keycloak_postgres_password ?= $(shell sops -d secrets.yaml | yq .keycloak.db.password -r)

export TF_VAR_argo_workflows_postgres_username ?= $(shell sops -d secrets.yaml | yq .argo_workflows.db.username -r)
export TF_VAR_argo_workflows_postgres_password ?= $(shell sops -d secrets.yaml | yq .argo_workflows.db.password -r)

# ===========================
#   PKI Variables
# ===========================
export ROOT_CA_PASSWORD := $(shell sops -d secrets.yaml | yq .pki.root_ca.password -r)
export ROOT_CA_ENCRYPTION_PASSWORD := $(shell sops -d secrets.yaml | yq .pki.root_ca.encryption_secret -r)
export INTERMEDIATE_CA_1_PASSWORD := $(shell sops -d secrets.yaml | yq .pki.intermediate_ca1.password -r)

PKI_DIR                 ?= pki
ROOT_CA_DIR             ?= $(PKI_DIR)/root-ca
ROOT_CA_KEY             ?= root-ca.key
ROOT_CA_CRT             ?= root-ca.crt
ROOT_CA_PASS_ENC		?= root-ca-pass.enc
ROOT_CA_CONF            ?= root-ca.conf
ROOT_CA_CONF_TEMPLATE   ?= templates/root-ca.conf
ROOT_CA_VALIDITY_DAYS   ?= 7300

# Intermediate CA 1 variables
INTERMEDIATE_CA_1_DIR        ?= $(PKI_DIR)/intermediate-ca-1
INTERMEDIATE_CA_1_KEY        ?= intermediate-ca-1.key
INTERMEDIATE_CA_1_CSR        ?= intermediate-ca-1.csr
INTERMEDIATE_CA_1_CRT        ?= intermediate-ca-1.crt
INTERMEDIATE_CA_1_CHAIN      ?= intermediate-ca-1-chain.pem
INTERMEDIATE_CA_1_CONF       ?= intermediate-ca-1.conf
INTERMEDIATE_CA_1_CONF_TEMPLATE ?= templates/intermediate-ca-1.conf

# Intermediate CA 2 variables
INTERMEDIATE_CA_2_DIR        ?= $(PKI_DIR)/intermediate-ca-2
INTERMEDIATE_CA_2_KEY        ?= intermediate-ca-2.key
INTERMEDIATE_CA_2_CSR        ?= intermediate-ca-2.csr
INTERMEDIATE_CA_2_CRT        ?= intermediate-ca-2.crt
INTERMEDIATE_CA_2_CHAIN      ?= intermediate-ca-2-chain.pem
INTERMEDIATE_CA_2_CONF       ?= intermediate-ca-2.conf
INTERMEDIATE_CA_2_CONF_TEMPLATE ?= templates/intermediate-ca-2.conf

INTERMEDIATE_CA_VALIDITY_DAYS ?= 3650

SERVER_DOMAIN_NAME	?= home.arpa
SERVER_DOMAIN_NAME_SLUG ?= home-arpa
SERVER_KEY              ?= $(SERVER_DOMAIN_NAME_SLUG).key
SERVER_CSR              ?= $(SERVER_DOMAIN_NAME_SLUG).csr
SERVER_CRT              ?= $(SERVER_DOMAIN_NAME_SLUG).crt
SERVER_CHAIN            ?= $(SERVER_DOMAIN_NAME_SLUG)-chain.pem
SERVER_CONF             ?= server.conf
SERVER_CONF_TEMPLATE    ?= templates/server.conf
SERVER_VALIDITY_DAYS    ?= 825
SERVER_SIGNING_DIR      ?= $(INTERMEDIATE_CA_2_DIR)

# Export necessary variables
export ROOT_CA_DIR
export INTERMEDIATE_CA_1_DIR
export SERVER_SIGNING_DIR

.PHONY: \
	help \
	ansible-run \
	ansible-check \
	ansible-dry-run \
	ansible-vault \
	pki-root \
	pki-intermediate \
	pki-clean \
	pki-server \ 
	terraform-plan \
	terraform-apply \
	terraform-destroy \
	sops

.DEFAULT_GOAL := help

.ONESHELL:

# ===========================
#         Targets
# ===========================
## Show available targets
help:
	@echo "Available targets:"
	@echo "  ansible-run        Run the Ansible playbook"
	@echo "  ansible-check      Syntax check the playbook"
	@echo "  ansible-dry-run    Run playbook in dry-run mode"
	@echo "  terraform-plan     Show Terraform plan"
	@echo "  terraform-apply    Apply Terraform changes"
	@echo "  root               Generate Root CA in PKI"
	@echo "  intermediate       Generate Intermediate CA in PKI"
	@echo "  server             Generate Server CA in PKI"
	@echo "  clean              Remove all PKI output (dangerous!)"
	@echo "  sops			    Unlock secrets with SOPS"
	@echo "  help               Show this help message"

## Run playbook
ansible-run:
	ansible-playbook -i "$(INVENTORY)" "$(PLAYBOOK)"

## Syntax check only
ansible-check:
	ansible-playbook -i "$(INVENTORY)" "$(PLAYBOOK)" --syntax-check

## Dry-run (check mode)
ansible-dry-run:
	ansible-playbook -i "$(INVENTORY)" "$(PLAYBOOK)" --check --diff

## Terraform plan
terraform-plan:
	@set -e; \
	terraform -chdir=terraform init; \
	terraform -chdir=terraform plan; \

## Terraform apply
terraform-apply:
	@set -e; \
	terraform -chdir=terraform init; \
	terraform -chdir=terraform apply -auto-approve; \

## Create Root CA
pki-root:
	@set -e; \
	ROOT_CA_DIR="$(ROOT_CA_DIR)"; \

	if [ -d "$(ROOT_CA_DIR)" ]; then \
		echo "[!] Root CA directory '$(ROOT_CA_DIR)' already exists. Aborting."; \
		exit 1; \
	fi; \

	if [ ! -d "$(ROOT_CA_DIR)" ]; then \
		mkdir -p "$(ROOT_CA_DIR)"; \
	fi
	cp -f templates/.pki.gitignore "$(PKI_DIR)/.gitignore"; \
	cp -f "${ROOT_CA_CONF_TEMPLATE}" "$(ROOT_CA_DIR)/$(ROOT_CA_CONF)"; \

	echo "[*] Creating Root CA directory structure..."; \
	mkdir -p "$(ROOT_CA_DIR)/certs" "$(ROOT_CA_DIR)/crl" "$(ROOT_CA_DIR)/newcerts" "$(ROOT_CA_DIR)/private"
	touch "$(ROOT_CA_DIR)/index.txt"
	echo 1000 > "$(ROOT_CA_DIR)/serial"
	echo 1000 > "$(ROOT_CA_DIR)/crlnumber"

	# Safety checks for empty passwords
	if [ -z "${ROOT_CA_PASSWORD}" ]; then echo "[!] Root CA password cannot be empty. Aborting."; exit 1; fi; \
	if [ -z "${ROOT_CA_ENCRYPTION_PASSWORD}" ]; then echo "[!] Encryption password cannot be empty. Aborting."; exit 1; fi; \

	echo "[*] Encrypting Root CA password..."; \
	echo "${ROOT_CA_PASSWORD}" | openssl enc -aes-256-cbc -salt -pbkdf2 -k "${ROOT_CA_ENCRYPTION_PASSWORD}" -iter 100000 -out "$(ROOT_CA_DIR)/$(ROOT_CA_PASS_ENC)"; \
	openssl genrsa -aes256 -passout pass:"${ROOT_CA_PASSWORD}" -out "$(ROOT_CA_DIR)/private/$(ROOT_CA_KEY)" 4096; \
	echo "[*] Creating Root CA certificate..."; \
	openssl req -config "$(ROOT_CA_DIR)/$(ROOT_CA_CONF)" -key "$(ROOT_CA_DIR)/private/$(ROOT_CA_KEY)" -new -x509 -days "$(ROOT_CA_VALIDITY_DAYS)" -sha256 -extensions v3_ca -passin pass:"$$ROOT_CA_PASSWORD" -out "$(ROOT_CA_DIR)/$(ROOT_CA_CRT)"; \
	echo "[*] Certificate details:"; \
	openssl x509 -noout -text -in "$(ROOT_CA_DIR)/$(ROOT_CA_CRT)"; \
	echo "[✓] Root CA creation complete. Files are in '$(ROOT_CA_DIR)'.";

## Create Intermediate CA
pki-intermediate:
	@set -e; \
	if [ -d "$(INTERMEDIATE_CA_1_DIR)" ]; then \
		echo "[!] Intermediate CA 1 directory '$(INTERMEDIATE_CA_1_DIR)' already exists. Aborting."; \
		exit 1; \
	fi; \

	if [ -z "${INTERMEDIATE_CA_1_PASSWORD}" ]; then \
		echo "[!] Intermediate CA 1 password cannot be empty. Aborting."; \
		exit 1; \
	fi; \

	mkdir -p "$(INTERMEDIATE_CA_1_DIR)/certs" "$(INTERMEDIATE_CA_1_DIR)/crl" "$(INTERMEDIATE_CA_1_DIR)/csr" "$(INTERMEDIATE_CA_1_DIR)/newcerts" "$(INTERMEDIATE_CA_1_DIR)/private"; \
	cp -f "${INTERMEDIATE_CA_1_CONF_TEMPLATE}" "$(INTERMEDIATE_CA_1_DIR)/$(INTERMEDIATE_CA_1_CONF)"; \
	touch "$(INTERMEDIATE_CA_1_DIR)/index.txt"; \
	echo 1000 > "$(INTERMEDIATE_CA_1_DIR)/serial"; \
	echo 1000 > "$(INTERMEDIATE_CA_1_DIR)/crlnumber"; \

	openssl genrsa -aes256 -passout pass:"${INTERMEDIATE_CA_1_PASSWORD}" -out "$(INTERMEDIATE_CA_1_DIR)/private/$(INTERMEDIATE_CA_1_KEY)" 4096; \

	openssl req -config "$(INTERMEDIATE_CA_1_DIR)/$(INTERMEDIATE_CA_1_CONF)" \
		-new -sha256 \
		-passin pass:"${INTERMEDIATE_CA_1_PASSWORD}" \
		-key "$(INTERMEDIATE_CA_1_DIR)/private/$(INTERMEDIATE_CA_1_KEY)" \
		-out "$(INTERMEDIATE_CA_1_DIR)/csr/$(INTERMEDIATE_CA_1_CSR)"; \

	if [ -z "${ROOT_CA_PASSWORD}" ]; then \
		echo "[!] Root CA password cannot be empty. Aborting."; \
		exit 1; \
	fi; \

	openssl ca -config "$(ROOT_CA_DIR)/$(ROOT_CA_CONF)" \
		-extensions v3_intermediate_ca \
		-days "$(INTERMEDIATE_CA_VALIDITY_DAYS)" \
		-notext -md sha256 \
		-passin pass:"${ROOT_CA_PASSWORD}" \
		-in "$(INTERMEDIATE_CA_1_DIR)/csr/$(INTERMEDIATE_CA_1_CSR)" \
		-out "$(INTERMEDIATE_CA_1_DIR)/$(INTERMEDIATE_CA_1_CRT)"; \

	openssl x509 -noout -text -in "$(INTERMEDIATE_CA_1_DIR)/$(INTERMEDIATE_CA_1_CRT)"; \

	cat "$(INTERMEDIATE_CA_1_DIR)/$(INTERMEDIATE_CA_1_CRT)" "$(ROOT_CA_DIR)/$(ROOT_CA_CRT)" > "$(INTERMEDIATE_CA_1_DIR)/$(INTERMEDIATE_CA_1_CHAIN)"; \

	openssl verify -CAfile "$(INTERMEDIATE_CA_1_DIR)/$(INTERMEDIATE_CA_1_CHAIN)" "$(INTERMEDIATE_CA_1_DIR)/$(INTERMEDIATE_CA_1_CRT)"; \

	echo "========== Creating Intermediate CA 2 =========="; \
	if [ -d "$(INTERMEDIATE_CA_2_DIR)" ]; then \
		echo "[!] Intermediate CA 2 directory '$(INTERMEDIATE_CA_2_DIR)' already exists. Aborting."; \
		exit 1; \
	fi; \

	mkdir -p "$(INTERMEDIATE_CA_2_DIR)/certs" "$(INTERMEDIATE_CA_2_DIR)/crl" "$(INTERMEDIATE_CA_2_DIR)/csr" "$(INTERMEDIATE_CA_2_DIR)/newcerts" "$(INTERMEDIATE_CA_2_DIR)/private"; \
	cp -f "${INTERMEDIATE_CA_2_CONF_TEMPLATE}" "$(INTERMEDIATE_CA_2_DIR)/$(INTERMEDIATE_CA_2_CONF)"; \
	touch "$(INTERMEDIATE_CA_2_DIR)/index.txt"; \
	echo 1000 > "$(INTERMEDIATE_CA_2_DIR)/serial"; \
	echo 1000 > "$(INTERMEDIATE_CA_2_DIR)/crlnumber"; \

	openssl genrsa -out "$(INTERMEDIATE_CA_2_DIR)/private/$(INTERMEDIATE_CA_2_KEY)" 4096; \

	openssl req -config "$(INTERMEDIATE_CA_2_DIR)/$(INTERMEDIATE_CA_2_CONF)" \
		-new -sha256 \
		-key "$(INTERMEDIATE_CA_2_DIR)/private/$(INTERMEDIATE_CA_2_KEY)" \
		-out "$(INTERMEDIATE_CA_2_DIR)/csr/$(INTERMEDIATE_CA_2_CSR)"; \

	openssl ca -config "$(INTERMEDIATE_CA_1_DIR)/$(INTERMEDIATE_CA_1_CONF)" \
		-extensions v3_intermediate_ca_2 \
		-days "$(INTERMEDIATE_CA_VALIDITY_DAYS)" \
		-notext -md sha256 \
		-passin pass:"${INTERMEDIATE_CA_1_PASSWORD}" \
		-in "$(INTERMEDIATE_CA_2_DIR)/csr/$(INTERMEDIATE_CA_2_CSR)" \
		-out "$(INTERMEDIATE_CA_2_DIR)/$(INTERMEDIATE_CA_2_CRT)"; \

	cat "$(INTERMEDIATE_CA_2_DIR)/$(INTERMEDIATE_CA_2_CRT)" "$(INTERMEDIATE_CA_1_DIR)/$(INTERMEDIATE_CA_1_CRT)" "$(ROOT_CA_DIR)/$(ROOT_CA_CRT)" > "$(INTERMEDIATE_CA_2_DIR)/$(INTERMEDIATE_CA_2_CHAIN)"; \

	openssl verify -CAfile "$(INTERMEDIATE_CA_2_DIR)/$(INTERMEDIATE_CA_2_CHAIN)" "$(INTERMEDIATE_CA_2_DIR)/$(INTERMEDIATE_CA_2_CRT)"; \

	openssl x509 -noout -text -in "$(INTERMEDIATE_CA_2_DIR)/$(INTERMEDIATE_CA_2_CRT)"; \

	echo "[✓] Intermediate CA certificates created successfully."; \

## Create Leaf CA
pki-server:
	@set -e; \
	if [ ! -d "${INTERMEDIATE_CA_2_DIR}" ]; then \
		echo "[!] Intermediate CA 2 directory '$(INTERMEDIATE_CA_2_DIR)' does not exist. Aborting."; \
		exit 1; \
	fi; \
	if [ ! -f "${INTERMEDIATE_CA_2_DIR}/${INTERMEDIATE_CA_2_CHAIN}" ]; then \
		echo "[!] Intermediate CA 2 chain file '$(INTERMEDIATE_CA_2_CHAIN)' does not exist. Aborting."; \
		exit 1; \
	fi; \
	cp -f "${SERVER_CONF_TEMPLATE}" "$(INTERMEDIATE_CA_2_DIR)"/$(SERVER_CONF); \
	openssl genpkey \
		-algorithm RSA \
		-out "$(INTERMEDIATE_CA_2_DIR)/private/$(SERVER_KEY)"; \
	chmod 400 "$(INTERMEDIATE_CA_2_DIR)/private/$(SERVER_KEY)"; \
	openssl req \
		-config "$(INTERMEDIATE_CA_2_DIR)/$(SERVER_CONF)" \
		-new -sha256 \
		-key "$(INTERMEDIATE_CA_2_DIR)/private/$(SERVER_KEY)" \
		-out "$(INTERMEDIATE_CA_2_DIR)/csr/$(SERVER_CSR)"; \
	openssl ca \
		-config "$(INTERMEDIATE_CA_2_DIR)/$(INTERMEDIATE_CA_2_CONF)" \
		-extensions server_cert \
		-days "$(SERVER_VALIDITY_DAYS)" \
		-notext -md sha256 \
		-in "$(INTERMEDIATE_CA_2_DIR)/csr/$(SERVER_CSR)" \
		-out "$(INTERMEDIATE_CA_2_DIR)/certs/$(SERVER_CRT)"
	
	echo "[✓] Server CA certificate created successfully."; \

## Danger! Delete all PKI files/output
pki-clean:
	@set -e; \
	if [ ! -d "$(PKI_DIR)" ]; then \
		echo "No PKI output directory called $(PKI_DIR) found to clean."; \
		exit 0; \
	fi; \
	echo "Cleaning up PKI directory: $(PKI_DIR)"; \
	rm -rf "$(PKI_DIR)"; \

## Unlock secrets with SOPS
sops:
	@set -e; \
	echo "Unlocking secrets file: $(SECRETS_FILE)"; \
	sops -d "$(SECRETS_FILE)" \
