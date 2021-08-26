# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# networklbaas.tf
#
# Purpose: The following script defines the logic for implementing LBaaS
# Registry: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/network_load_balancer_network_load_balancer

resource "oci_network_load_balancer_network_load_balancer" "NetworkLoadBalancer" {
  count          = var.is_app_lbaas ? 0 : 1
  compartment_id = local.compartment_id
  display_name   = var.lbaas_display_name
  subnet_id      = local.subnet_ocid

  is_preserve_source_destination = var.is_preserve_source_destination
  is_private                     = var.is_private
  network_security_group_ids     = local.nsg_id == "" ? [] : [local.nsg_id]

  dynamic "reserved_ips" {
    for_each = var.reserved_ip_id == "" ? [] : [1]
    content {
      id = var.reserved_ip_id
    }
  }
}
