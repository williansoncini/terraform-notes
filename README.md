- [variables](#variables)
  - [type](#type)
    - [Tipos básicos](#tipos-básicos)
    - [Tipos complexos](#tipos-complexos)
  - [default](#default)
  - [description](#description)
  - [Exemplo de uso](#exemplo-de-uso)
  - [Passando valores para variável](#passando-valores-para-variável)
    - [Forma padrão](#forma-padrão)
    - [Com variável de ambiente](#com-variável-de-ambiente)
    - [Com arquivo de variavel - terraform.tfvars](#com-arquivo-de-variavel---terraformtfvars)
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

- list
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

# Referencias

https://www.youtube.com/watch?v=RLwvMDgVU80&list=PLN1VdoAQkZb0TbGhDuE--tg1oaxfa9qcA&ab_channel=souzaxx