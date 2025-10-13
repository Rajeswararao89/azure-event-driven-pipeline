
# Azure Event Pipeline - Deliverable 3 (Code & Scripts)

This repository contains a ready-to-deploy skeleton for the Azure-based event-driven pipeline required by the assignment.

## What is included
- Terraform infra under `infra/` to create Resource Group, Storage Account (and containers), App Service Plan, Function Apps, and Application Insights.
- Two Azure Functions under `functions/`:
  - `ingest_function` (Blob trigger) - moves data from `raw/` to `processed/` with a small transform.
  - `report_function` (Timer trigger) - aggregates processed blobs and writes a daily CSV report to `reports/`.
- GitHub Actions workflow `.github/workflows/azure-deploy.yml` to run Terraform and deploy function packages.
- `build_functions.sh` to package functions into zip files.

## Quickstart (local)
1. Install Azure CLI, Terraform, and Python 3.10.
2. Create an Azure Service Principal and set `AZURE_CREDENTIALS` secret in GitHub (JSON).
3. Update variables in `infra/variables.tf` if desired.
4. Run locally:
   ```bash
   ./build_functions.sh
   cd infra
   terraform init
   terraform apply -auto-approve
   ```
5. After infra is created, set the following GitHub secrets for deployment via Actions:
   - `AZURE_CREDENTIALS` (service principal JSON)
   - `AZURE_RESOURCE_GROUP`
   - `AZURE_FUNCTIONAPP_NAME_INGEST`
   - `AZURE_FUNCTIONAPP_NAME_REPORT`

## Notes
- Event Grid subscription for Blob Created events can be created in Azure Portal to point to the ingest function, or created via Azure CLI.
- For production, use Key Vault for secrets and configure Terraform backend state in Azure Storage with locking.
- Clean up resources with `terraform destroy` when done.
