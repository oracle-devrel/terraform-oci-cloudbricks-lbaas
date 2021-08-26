# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# output.tf
#
# Purpose: The following script defines the output for LBaaS Creation


output "app_lbaas_instance" {
  value = oci_load_balancer.AppLoadBalancer
}

output "network_lbaas_instance" {
  value = oci_network_load_balancer_network_load_balancer.NetworkLoadBalancer
}
