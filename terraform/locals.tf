locals {
  namespaced_service_name = "${var.service_name}-${var.env_type}"

  lambdas_path = "${path.module}/../lambdas"
  layers_path  = "${local.lambdas_path}/layers"

  lambdas = {
    get = {
      description = "Get employees"
      memory      = 256
      timeout     = 10
    }
    delete = {
      description = "Delete given employee"
      memory      = 128
      timeout     = 5
    }
    put = {
      description = "Update given employee"
      memory      = 128
      timeout     = 5
    }
    post = {
      description = "Create new employee"
      memory      = 128
      timeout     = 5
    }
  }
}
