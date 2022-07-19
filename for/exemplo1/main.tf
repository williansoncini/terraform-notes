variable "cars" {
  type = map(object({
    color = string
    year  = number
  }))

  default = {
    "Fusca" : {
      "color" = "black"
      "year"  = "1980"
    }
    "Tesla" : {
      "color" = "black"
      "year"  = "2022"
    }
  }
}