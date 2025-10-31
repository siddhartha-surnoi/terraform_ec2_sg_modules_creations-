variable "vpc_id" {}
variable "allowed_cidr" {}
variable "sg_config" {
  type = map(object({
    desc  = string
    ports = list(number)
  }))
}
variable "tags" {
  type = map(string)
}