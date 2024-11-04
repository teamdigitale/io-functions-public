data "azurerm_api_management" "apim" {
  name                = "${local.project_legacy}-apim-v2-api"
  resource_group_name = "${local.project_legacy}-rg-internal"
}

data "azurerm_api_management" "apim_itn" {
  name                = local.apim_itn.name
  resource_group_name = local.apim_itn.resource_group_name
}

data "azurerm_key_vault" "key_vault_common" {
  name                = "${local.project_legacy}-kv-common"
  resource_group_name = "${local.project_legacy}-rg-common"
}
