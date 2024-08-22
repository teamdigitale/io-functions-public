locals {
  project = "io-p"

  identity_resource_group_name = "${local.project}-identity-rg"

  repo_secrets = {
    "ARM_TENANT_ID"       = data.azurerm_client_config.current.tenant_id,
    "ARM_SUBSCRIPTION_ID" = data.azurerm_subscription.current.subscription_id
  }

  ci = {
    secrets = {
      "ARM_CLIENT_ID" = data.azurerm_user_assigned_identity.identity_prod_ci.client_id
    }
  }

  cd = {
    secrets = {
      "ARM_CLIENT_ID" = data.azurerm_user_assigned_identity.identity_prod_cd.client_id
    }
    reviewers_teams = ["io-backend-admin", "io-backend-contributors", "engineering-team-cloud-eng"]
  }

  # OPEX
  ci_opex = {
    secrets = {
      "ARM_CLIENT_ID" = data.azurerm_user_assigned_identity.identity_opex_prod_ci.client_id
    }
  }

  cd_opex = {
    secrets = {
      "ARM_CLIENT_ID" = data.azurerm_user_assigned_identity.identity_opex_prod_cd.client_id
    }
    reviewers_teams = ["io-backend-contributors", "io-backend-admin", "engineering-team-cloud-eng"]
  }
  
}