# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# output.tf
#
# Purpose: The following script defines the output for LBaaS Creation

output "ip_address_details" {
  value = [oci_load_balancer.LoadBalancer.ip_address_details]
}

output "nsg" {
  value = oci_load_balancer.LoadBalancer.network_security_group_ids
}

output "shape" {
  value = oci_load_balancer.LoadBalancer.shape
}

output "lbaas_instance" {
  value = oci_load_balancer.LoadBalancer
}
