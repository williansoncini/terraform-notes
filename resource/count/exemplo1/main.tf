resource "local_file" "count" {
  count = 4

  filename = "./arquivo_${count.index}"
  content  = "Esse é o arquivo ${count.index}"
}

