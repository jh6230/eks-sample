terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15"
    }
  }

  backend "s3" {
    bucket = "eks-sample-remote-state-445605964569"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }

  required_version = ">= 1.5.5"
}

provider "aws" {
  region = "ap-northeast-1"
}
