# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# variables.tf 
#
# Purpose: The following file declares all variables used in this backend repository


/********** Provider Variables NOT OVERLOADABLE **********/

variable "region" {
  description = "Target region where artifacts are going to be created"
}

variable "tenancy_ocid" {
  description = "OCID of tenancy"
}

variable "user_ocid" {
  description = "User OCID in tenancy. Currently hardcoded to user denny.alquinta@oracle.com"
}

variable "fingerprint" {
  description = "API Key Fingerprint for user_ocid derived from public API Key imported in OCI User config"
}

variable "private_key_path" {
  description = "Private Key Absolute path location where terraform is executed"

}

/********** Provider Variables NOT OVERLOADABLE **********/

/********** Brick Variables **********/

/********** LBaaS Variables **********/

variable "lbaas_shape" {
  description = "A template that determines the total pre-provisioned bandwidth (ingress plus egress). To get a list of available shapes, use the ListShapes operation. Example: 100Mbps"
  default     = "flexible"
}

variable "lbaas_display_name" {
  description = "A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: example_load_balancer"
}

variable "is_private" {
  description = "Whether the load balancer has a VCN-local (private) IP address."
  default     = true
  type        = bool
}

variable "lb_nsg_name" {
  description = "Display Name of an optional Network Security Group"
  default     = ""
}

variable "lbaas_instance_compartment_name" {
  description = "Defines the compartment name where the infrastructure will be created"
}

variable "lbaas_network_compartment_name" {
  description = "Defines the compartment where the Network is currently located"
}

variable "is_reserved_ip" {
  description = "Boolean that determines if reserved ip should be used"
  default     = false
  type        = bool
}

variable "reserved_ip_id" {
  description = "Resereved ip address OCID"
  default     = ""
}
variable "lbaas_shape_max_bw_mbps" {
  description = "Bandwidth in Mbps that determines the maximum bandwidth (ingress plus egress) that the load balancer can achieve. This bandwidth cannot always guaranteed. For a guaranteed bandwidth use the minimumBandwidthInMbps parameter. The values must be between minimumBandwidthInMbps and the highest limit available in multiples of 10. The highest limit available is defined in Service Limits. Example: 1500"
  default     = "10"
}

variable "lbaas_shape_min_bw_mbps" {
  description = "Bandwidth in Mbps that determines the total pre-provisioned bandwidth (ingress plus egress). The values must be between 0 and the maximumBandwidthInMbps in multiples of 10. The current allowed maximum value is defined in Service Limits. Example: 150"
  default     = "10"
}

variable "is_preserve_source_destination" {
  description = "This optional parameter can be enabled only if backends are compute OCIDs. When enabled, the skipSourceDestinationCheck parameter is automatically enabled on the load balancer VNIC, and packets are sent to the backend with the entire IP header intact."
  default     = false
  type        = bool
}

variable "is_app_lbaas" {
  description = "Determines whether load balancer is an application load balancer, setting this to false will generate a network load balancer"
  default     = true
  type        = bool
}

/********** LBaaS Variables **********/

/********** Datasource and Subnet Lookup related variables **********/

variable "network_subnet_name" {
  description = "Defines the specific Subnet to be used for this resource"
}

variable "vcn_display_name" {
  description = "VCN Display name to execute lookup"
}

/********** Datasource related variables **********/

/********** Brick Variables **********/
