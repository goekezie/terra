variable "app_service_plan_name" {
  description = "The name used to identify the app service"
  default     = ["tailspin-space-game-test-asp"]
}

variable "sku_size" {
  description = "The sku size"
  default     = ["B1"]
}

variable "sku_tier" {
  description = "The sku tier"
  default     = ["Standard"]
}


variable "app_service_name" {
  description = "The name used to identify the app service"
#   default     = ["tailspin-space-game-web-dev-909", "tailspin-space-game-web-test-909", "tailspin-space-game-web-staging-909"]
}

# variable "app_service_plan_id" {
#   description = "The app service plan id"
# }