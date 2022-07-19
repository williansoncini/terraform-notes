// Retorno de lista

output "todos_carros" {
  value = [
    for car in var.cars :
    car.color
  ]
}

// Fazendo um filtro de ano
output "somente_carros_de_2022" {
  value = [for car in var.cars :
  car.color
  if car.year == 2022
  ]
}

output "bora_mudar_um_pouco_as_chaves" {
  value = {
    for key, val in var.cars :
    val.year => {
      "teste": key
      "teste_2" : val.color
    }
  }
}