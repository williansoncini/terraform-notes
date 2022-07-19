variable "arquivos" {
  default = {
    arquivo_1 = "Primeiro arquivo",
    arquivo_2 = <<EOF
Baita conteudo formatado
Dentro do 
Arquivo
:3
EOF
  }
}

resource "local_file" "count_map" {
  for_each = var.arquivos

  filename = each.key
  content  = each.value
}