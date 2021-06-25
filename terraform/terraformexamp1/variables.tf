variable "resourcegroup"{
    description = "Enter the value on resourcegroup"
    validation {
    condition     = length(var.resourcegroup) > 4 && substr(var.resourcegroup, 0, 4) == "myr-"
    error_message = "The image_id value must be a valid AMI id, starting with \"myr-\"."
  }
}

variable "resourcegrp" {
    default="myrgd"
}