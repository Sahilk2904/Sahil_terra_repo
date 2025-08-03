terraform {
  required_providers {
    azurerm = {
      source  = "registry.terraform.io/hashicorp/azurerm"
      version = "4.37.0"
    }
  }
}
# terraform {
#   backend "azurerm" {
#     #access_key           = "abcdefghijklmnopqrstuvwxyz0123456789..."
#     resource_group_name  = "SC_test"           # Can also be set via `ARM_ACCESS_KEY` environment variable.
#     storage_account_name = "scteststg21"       # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
#     container_name       = "sahilcontainer"    # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
#     key                  = "terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
#   }
# }
provider "azurerm" {

  features {}
  #configuration_option
  subscription_id = "5fffa1ff-217c-45ea-ad98-83726d1375b9"
}
