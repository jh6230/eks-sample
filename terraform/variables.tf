variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "cidr" {
  description = "VPC Cidr"
  type        = string
}

variable "azs" {
  description = "VPC Availavirity zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "VPC Private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "VPC Public subnets"
  type        = list(string)
}

variable "intra_subnets" {
  description = "VPC Intra subnets"
  type        = list(string)
}


variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}
