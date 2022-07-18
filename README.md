- [variables](#variables)
  - [type](#type)
    - [Tipos básicos](#tipos-básicos)
    - [Tipos complexos](#tipos-complexos)
      - [list](#list)
      - [map](#map)
      - [Objects](#objects)
      - [Sensitivo](#sensitivo)
      - [Validation](#validation)
  - [default](#default)
  - [description](#description)
  - [Exemplo de uso](#exemplo-de-uso)
  - [Passando valores para variável](#passando-valores-para-variável)
    - [Forma padrão](#forma-padrão)
    - [Com variável de ambiente](#com-variável-de-ambiente)
    - [Com arquivo de variavel - terraform.tfvars](#com-arquivo-de-variavel---terraformtfvars)
- [Resource](#resource)
  - [Provider](#provider)
    - [Local](#local)
- [Referencias](#referencias)

# variables

Declaração de como é feita

```ruby
variable "nome_variavel" {
  type = string
  default =  "valor padrão"
  description = "Para que essa variável importa?"
}
```

## type

Tipo da variável

### Tipos básicos

- string
  - Aceitará apenas texto
  - `default = "valor"`
- number
  - Aceitara apenas números
  - `default = 1`
- bool
  - Valores true ou false
  - `default = true`

### Tipos complexos

#### list

- Aceitará somente uma lista
- Podendo passar o tipo da lista
- `default = ["80","8080","1234"]`

Mais exemplos de lista

`Lista somente de string`

```ruby
variable "teste" ={
  type = list(string)
  default = ["lista", "de", "string"]
}
```

`Pegando um valor especifico da lista`

> Aqui você pode usar index ou umaa função para pegar a posição desejada

```ruby
output "teste" ={
  type = var.lista[0]
  description = "Somente teste"
}
```

`Exemplo com função`

```ruby
output "teste" ={
  type = var.lista[length(var.lista) - 1]
  description = "Somente teste"
}
```

#### map

É um dicionário :3

```ruby
variable "teste" ={
  type = map(string)
  default = {
    "a" = "A",
    "b" = "B"
  }
}

output "print_teste" {
  value = var.teste
}
```

```bash
{
  "a" = "A",
  "b" = "B"
}
```

#### Objects

```ruby
variable "usuarios" ={
  type = map(object({
    email = string
    departamento = string
  }))

  default = {
    "teste" : {
      "email" = "teste@teste.com",
      "departamento" = "teste"
    }
    "teste_2": {
      "email" = "teste_2@teste.com",
      "departamento" = "teste"
    }
  }
}
```

#### Sensitivo

Usado para ocultar valores no output, mas cara, cuidado, esses valoress ainda ficam gravados no state do terraform. Então para realmente ocultar os valores será necessário uma outra abordagem

```ruby
variable "senha_super_secreta" = {
  type = string
  sensitive= true
}

output "senha_super_secreta" {
  value = var.senha_suoer_secreta
  sensitive = true
}
```

#### Validation

Utilizado para colocar validações no input das variables. Da para colocar condições que obrigue o valor ser informado da forma correta :)

```ruby
variable "nome" = {
  type = string
  description = "O nome deve conter willian"

  validation {
    condition = contains(["willain"], var.nome) 
    error_message = "O valor informado está incoreto!"
  }
}
 
output "nome" {
  value = var.nome
}
```

## default

Valor padrão da variável

> Aceitará somente valores que forem compatíveis com o tipo da variável

## description

Descrição sobre oque é a variável

> De uma descrição para a variável, explicando para que ela serve :)

## Exemplo de uso

```ruby
variable "nome_vm" {
  type        = string
  default     = "nome_vm"
  description = "Nome da máquina virtual"
}

output "teste" {
  value       = var.nome_vm
  description = "teste"
}
```

`terraform apply`

## Passando valores para variável

### Forma padrão

```bash
terraform apply -var="nome_vm="novo_nome_vm""
```

Para alterar mais de uma variável faça:

```bash
terraform apply -var="nome_variavel="valor"" -var="outra_variavel=10"
```

### Com variável de ambiente

Podemos criar variáveis de ambiente começando com TF_VAR para indicar que é uma variável do terraform

Desta maneira o terraform irá entender que tal variável será para ele, e mediante ao restante do nome da variável ele encaixará tal valor para a variável em seus arquivos

Exemplo:

`main.tf`

```ruby
variable "nome_vm" {
  type        = string
  default     = "nome_vm"
}

output "teste" {
  value       = var.nome_vm
  description = "Nome da máquina virtual"
}
```

`bash`

```bash
export TF_VAR_nome_vm="maquina_do_sucesso"
terraform apply
```

`output`

```bash
Changes to Outputs:
  ~ teste = "teste" -> "maquina_do_sucesso"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

teste = "maquina_do_sucesso"
```

Repare que apenas foi utilizado `terraform apply` não foi necessário indicar a variável, devido ele reconhecer automaticamente a variável de ambiente TF_vAR

### Com arquivo de variavel - terraform.tfvars

Criar um arquivo `terraform.tfvars` na pasta do terraform

A identação do arquivo é bem simples

Variável = "valor"

Exemplo:

`terraform.tfvars`

```ruby
nome_vm = "pc_potente"
zone = "us-central-1"
```

Quando você rodar o comando `terraform apply` ele buscará por esse arquivo automaticamente :)

# Resource

Cada resource contém um tipo único de input, por cota disso é muito importante ir na documentação e checar os tipos validos

## Provider

### Local




# Referencias

https://www.youtube.com/watch?v=RLwvMDgVU80&list=PLN1VdoAQkZb0TbGhDuE--tg1oaxfa9qcA&ab_channel=souzaxx