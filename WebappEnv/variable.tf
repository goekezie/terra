variable "app_service_plan_name" {
  description = "The name used to identify the app service"
  default     = ["tailspin-space-game-test-asp", "tailspin-space-game-prod-asp"]
}

variable "sku" {
  description = "The sku version"
  default     = ["B1", "P1V2"]
}

variable "app_service_name" {
  description = "The name used to identify the app service"
#   default     = ["tailspin-space-game-web-dev-909", "tailspin-space-game-web-test-909", "tailspin-space-game-web-staging-909"]
}