variable "nome_vm" {
  type        = string
  default     = "nome_vm"
}

output "teste" {
  value       = var.nome_vm
  description = "Nome da máquina virtual"
}