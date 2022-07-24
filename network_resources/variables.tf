variable "vpc-name" {
    type = string
}
variable "vpc-auto" {
    type = bool
}
variable "subnet-name" {
  type = string
}
variable "subnet-ip" {
    type = string
}
variable "subnet-region" {
    type = string
}
variable "router-name" {
   type = string
}
variable "router-asn" {
  type = number
}
variable "nat-name" {
  type = string
}
variable "nat-ip" {
  type = string
}
variable "natsource" {
  type = string
}
