# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# compute.tf
#
# Purpose: The following script defines the logic for implementing LBaaS
# Registry: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_load_balancer


resource "oci_load_balancer" "LoadBalancer" {
  shape          = var.lbaas_shape
  compartment_id = local.compartment_id
  subnet_ids     = [local.subnet_ocid]

  display_name = var.lbaas_display_name
  is_private   = var.is_private
  shape_details {
    maximum_bandwidth_in_mbps = var.lbaas_shape_max_bw_mbps
    minimum_bandwidth_in_mbps = var.lbaas_shape_min_bw_mbps
  }
}
