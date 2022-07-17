output "main_url" {
  description = "main_url da api"
  value       = module.apigateway.main_url
}
output "Endpoint" {
  description = "Endpoint to invoke api"
  value       = module.apigateway.invoke_url
}
output "local_adduser_url" {
  value = module.apigateway.local_adduser_url
}