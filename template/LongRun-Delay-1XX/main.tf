#################################################################
# Terraform template that will poll Infrastructure Management for approval
#
# Version: 2.4
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Licensed Materials - Property of IBM
#
# ©Copyright IBM Corp. 2020.
#
#################################################################

#########################################################
# Define the variables
#########################################################
variable "wait_time" {
    default = 30
    description = "Wait time in seconds"
}

#########################################################
# Create file to store script output
#########################################################
resource "local_file" "delay_output" {
    content   = ""
    filename  = "${path.module}/delay_output"
}

#########################################################
# Poll Infrastructure Management for approval status
#########################################################
resource "null_resource" "init_delay" {
 provisioner "local-exec" {
    command = "/bin/bash init_delay.sh $WAIT_TIME $FILE"
    environment = {
      WAIT_TIME    = var.wait_time
      FILE         = "${path.module}/delay_output"
    }
  }
  depends_on = [
    local_file.delay_output
  ] 
}

#########################################################
# Output
#########################################################
output "ready_set_go" {
  value = "${fileexists("${local_file.delay_output.filename}") ? file("${local_file.delay_output.filename}") : ""}"
  depends_on = [
    null_resource.init_delay
  ] 
}
