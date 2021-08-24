# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# compute.tf
#
# Purpose: The following script defines the logic for implementing LBaaS
# Registry: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_load_balancer


resource "oci_load_balancer" "LoadBalancer" {
  compartment_id = local.compartment_id
  display_name = var.lbaas_display_name
  shape          = var.lbaas_shape
  subnet_ids     = [local.subnet_ocid]

  is_private   = var.is_private
  network_security_group_ids = local.nsg_id == "" ? [] : [local.nsg_id]
  dynamic "reserved_ips" {
    for_each = var.is_reserved_ip ? [1] : []
    content {
      id = var.reserved_ip_id
    }
  }
  shape_details {
    maximum_bandwidth_in_mbps = var.lbaas_shape_max_bw_mbps
    minimum_bandwidth_in_mbps = var.lbaas_shape_min_bw_mbps
  }
}
