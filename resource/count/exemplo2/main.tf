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
  count = length(keys(var.arquivos))

  filename = keys(var.arquivos)[count.index]
  content  = var.arquivos[keys(var.arquivos)[count.index]]
}