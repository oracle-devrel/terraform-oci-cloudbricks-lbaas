# OCI Cloud Bricks: Load Balancer

[![License: UPL](https://img.shields.io/badge/license-UPL-green)](https://img.shields.io/badge/license-UPL-green) [![Quality gate](https://sonarcloud.io/api/project_badges/quality_gate?project=oracle-devrel_terraform-oci-cloudbricks-lbaas)](https://sonarcloud.io/dashboard?id=oracle-devrel_terraform-oci-cloudbricks-lbaas)

## Introduction
The following brick allows for provisioning an application or network load balancer in OCI. 

### Prerequisites
- Pre-baked Artifact and Network Compartments
- Pre-baked VCN

---

# Sample tfvars file 

If using application LBaaS, flexible shape.

```shell
########## Application LBaaS, Flexible Shape ##########
########## SAMPLE TFVAR FILE ##########
######################################## COMMON VARIABLES ######################################
region           = "foo-region-1"
tenancy_ocid     = "ocid1.tenancy.oc1..abcdefg"
user_ocid        = "ocid1.user.oc1..aaaaaaabcdefg"
fingerprint      = "fo:oo:ba:ar:ba:ar"
private_key_path = "/absolute/path/to/api/key/your_api_key.pem"
######################################## COMMON VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
lbaas_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
lbaas_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                = "MY_VCN"
network_subnet_name             = "MY_SUBNET"
lbaas_display_name              = "LBaaS_Name"
lbaas_shape                     = "flexible"
lbaas_shape_min_bw_mbps         = "100"
lbaas_shape_max_bw_mbps         = "100"
is_private                      = true
lb_nsg_name                     = "MY_NSG"
is_app_lbaas                    = true
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## Application LBaaS, Flexible Shape ##########
```

If using application LBaaS, dynamic shape.

```shell
########## Application LBaaS, Dynamic Shape ##########
########## SAMPLE TFVAR FILE ##########
######################################## COMMON VARIABLES ######################################
region           = "foo-region-1"
tenancy_ocid     = "ocid1.tenancy.oc1..abcdefg"
user_ocid        = "ocid1.user.oc1..aaaaaaabcdefg"
fingerprint      = "fo:oo:ba:ar:ba:ar"
private_key_path = "/absolute/path/to/api/key/your_api_key.pem"
######################################## COMMON VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
lbaas_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
lbaas_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                = "MY_VCN"
network_subnet_name             = "MY_SUBNET"
lbaas_display_name              = "LBaaS_Name"
lbaas_shape                     = "100Mbps"
is_private                      = true
lb_nsg_name                     = "MY_NSG"
is_app_lbaas                    = true
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## Application LBaaS, Dynamic Shape ##########
```

If using network LBaaS.

```shell
########## Network LBaaS ##########
########## SAMPLE TFVAR FILE ##########
######################################## COMMON VARIABLES ######################################
region           = "foo-region-1"
tenancy_ocid     = "ocid1.tenancy.oc1..abcdefg"
user_ocid        = "ocid1.user.oc1..aaaaaaabcdefg"
fingerprint      = "fo:oo:ba:ar:ba:ar"
private_key_path = "/absolute/path/to/api/key/your_api_key.pem"
######################################## COMMON VARIABLES ######################################
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
lbaas_instance_compartment_name = "MY_ARTIFACT_COMPARTMENT"
lbaas_network_compartment_name  = "MY_NETWORK_COMPARTMENT"
vcn_display_name                = "MY_VCN"
network_subnet_name             = "MY_SUBNET"
lbaas_display_name              = "LBaaS_Name"
is_private                      = true
lb_nsg_name                     = "MY_NSG"
is_app_lbaas                    = false
is_preserve_source_destination  = false
######################################## ARTIFACT SPECIFIC VARIABLES ######################################
########## SAMPLE TFVAR FILE ##########
########## Network LBaaS ##########
```

### Variable Specific Conisderions
- Optional variable `reserved_ip_id` allows for attaching an Oracle reserver IP to the load balancer. You must supply the OCID of the reserved IP, for example "ocid1.publicip.oc1.re-region-1.amaaaaaa...". Do not provide a reserved IP when `is_private` is set to true, as this will change the load balancer to public.
- Variable `lb_nsg_name` is an optional network security group that can be attached.
- Boolean variable `is_app_lbaas` is used to specify between an application load balancer (true), and a network load balancer (false). 
- Variable `lbaas_shape` accepts the following values: `10Mbps-Micro`, `10Mbps`, `100Mbps`, `400Mbps`, `8000Mbps` or `flexible`. 
  - *Note1*: The `flexible` shape is used with the variables `lbaas_shape_min_bw_mbps` and `lbaas_shape_max_bw_mbps` to specify the minimum and maximum bandwidth respectively. Values can be between 10 (Mbps) and 8000 (Mbps).
  - *Note2*: The `10Mbps-Micro` shape cannot be updated to any other shape nor can any other shape be updated to `10Mbps-Micro`.
  - *Note3*: No shape is specified for a network load balancer.

### Sample provider
The following is the base provider definition to be used with this module

```shell
terraform {
  required_version = ">= 0.13.5"
}
provider "oci" {
  region       = var.region
  tenancy_ocid = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  disable_auto_retries = "true"
}

provider "oci" {
  alias        = "home"
  region       = data.oci_identity_region_subscriptions.home_region_subscriptions.region_subscriptions[0].region_name
  tenancy_ocid = var.tenancy_ocid  
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  disable_auto_retries = "true"
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 4.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_load_balancer.AppLoadBalancer](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer) | resource |
| [oci_network_load_balancer_network_load_balancer.NetworkLoadBalancer](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/network_load_balancer_network_load_balancer) | resource |
| [oci_core_network_security_groups.NSG](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_network_security_groups) | data source |
| [oci_core_subnets.SUBNET](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_subnets) | data source |
| [oci_core_vcns.VCN](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_vcns) | data source |
| [oci_identity_compartments.COMPARTMENTS](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_compartments) | data source |
| [oci_identity_compartments.NWCOMPARTMENTS](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_compartments) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_fingerprint"></a> [fingerprint](#input\_fingerprint) | API Key Fingerprint for user\_ocid derived from public API Key imported in OCI User config | `any` | n/a | yes |
| <a name="input_is_app_lbaas"></a> [is\_app\_lbaas](#input\_is\_app\_lbaas) | Determines whether load balancer is an application load balancer, setting this to false will generate a network load balancer | `bool` | `true` | no |
| <a name="input_is_preserve_source_destination"></a> [is\_preserve\_source\_destination](#input\_is\_preserve\_source\_destination) | This optional parameter can be enabled only if backends are compute OCIDs. When enabled, the skipSourceDestinationCheck parameter is automatically enabled on the load balancer VNIC, and packets are sent to the backend with the entire IP header intact. | `bool` | `false` | no |
| <a name="input_is_private"></a> [is\_private](#input\_is\_private) | Whether the load balancer has a VCN-local (private) IP address. | `bool` | `true` | no |
| <a name="input_lb_nsg_name"></a> [lb\_nsg\_name](#input\_lb\_nsg\_name) | Display Name of an optional Network Security Group | `string` | `""` | no |
| <a name="input_lbaas_display_name"></a> [lbaas\_display\_name](#input\_lbaas\_display\_name) | A user-friendly name. It does not have to be unique, and it is changeable. Avoid entering confidential information. Example: example\_load\_balancer | `any` | n/a | yes |
| <a name="input_lbaas_instance_compartment_name"></a> [lbaas\_instance\_compartment\_name](#input\_lbaas\_instance\_compartment\_name) | Defines the compartment name where the infrastructure will be created | `any` | n/a | yes |
| <a name="input_lbaas_network_compartment_name"></a> [lbaas\_network\_compartment\_name](#input\_lbaas\_network\_compartment\_name) | Defines the compartment where the Network is currently located | `any` | n/a | yes |
| <a name="input_lbaas_shape"></a> [lbaas\_shape](#input\_lbaas\_shape) | A template that determines the total pre-provisioned bandwidth (ingress plus egress). To get a list of available shapes, use the ListShapes operation. Example: 100Mbps | `string` | `"flexible"` | no |
| <a name="input_lbaas_shape_max_bw_mbps"></a> [lbaas\_shape\_max\_bw\_mbps](#input\_lbaas\_shape\_max\_bw\_mbps) | Bandwidth in Mbps that determines the maximum bandwidth (ingress plus egress) that the load balancer can achieve. This bandwidth cannot always guaranteed. For a guaranteed bandwidth use the minimumBandwidthInMbps parameter. The values must be between minimumBandwidthInMbps and the highest limit available in multiples of 10. The highest limit available is defined in Service Limits. Example: 1500 | `string` | `"10"` | no |
| <a name="input_lbaas_shape_min_bw_mbps"></a> [lbaas\_shape\_min\_bw\_mbps](#input\_lbaas\_shape\_min\_bw\_mbps) | Bandwidth in Mbps that determines the total pre-provisioned bandwidth (ingress plus egress). The values must be between 0 and the maximumBandwidthInMbps in multiples of 10. The current allowed maximum value is defined in Service Limits. Example: 150 | `string` | `"10"` | no |
| <a name="input_network_subnet_name"></a> [network\_subnet\_name](#input\_network\_subnet\_name) | Defines the specific Subnet to be used for this resource | `any` | n/a | yes |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | Private Key Absolute path location where terraform is executed | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Target region where artifacts are going to be created | `any` | n/a | yes |
| <a name="input_reserved_ip_id"></a> [reserved\_ip\_id](#input\_reserved\_ip\_id) | Resereved ip address OCID | `string` | `""` | no |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | OCID of tenancy | `any` | n/a | yes |
| <a name="input_user_ocid"></a> [user\_ocid](#input\_user\_ocid) | User OCID in tenancy. Currently hardcoded to user denny.alquinta@oracle.com | `any` | n/a | yes |
| <a name="input_vcn_display_name"></a> [vcn\_display\_name](#input\_vcn\_display\_name) | VCN Display name to execute lookup | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_lbaas_instance"></a> [app\_lbaas\_instance](#output\_app\_lbaas\_instance) | n/a |
| <a name="output_network_lbaas_instance"></a> [network\_lbaas\_instance](#output\_network\_lbaas\_instance) | n/a |

## Contributing
This project is open source.  Please submit your contributions by forking this repository and submitting a pull request!  Oracle appreciates any contributions that are made by the open source community.

## License
Copyright (c) 2021 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](LICENSE) for more details.
