variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "control_plane_subnet_ids" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}
