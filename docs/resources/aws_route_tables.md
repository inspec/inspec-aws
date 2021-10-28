---
title: About the aws_route_tables Resource
---

# aws\_route\_tables

Use the `aws_route_tables` InSpec audit resource to test the properties of all route tables or a group of route tables, and all routes or a group of routes. A route table contains a set of rules, called routes, that are used to determine where network traffic is directed.

## Syntax

    describe aws_route_tables do
      it { should exist }
    end

### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on route tables](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-route-table.html).

## Properties

|Property                                    | Description                                       |   Field           |
| ----------------------------               | ---------------------------------                 |   ---             |
| route\_table\_ids                          | The route table IDs                               | `route_table_id`  |
| vpc\_ids                                   | The VPC IDs                                       | `vpc_id`          |
| entries                                    | Provides access to the raw results of the query, which can be treated as an array of hashes. | Not Applicable | 
| routes(carrier\_gateway\_ids)              | The ID of the carrier gateway.                    | `carrier_gateway_id` |
| routes(destination\_cidr\_blocks)          | The IPv4 CIDR block used for the destination match.| `destination_cidr_block`        |
| routes(destination\_ipv\_6\_cidr\_blocks)  | The IPv6 CIDR block used for the destination match.| `destination_ipv_6_cidr_block`  |
| routes(destination\_prefix\_list\_ids)     | The prefix of the AWS service.                     | `destination_prefix_list_id`    |
| routes(egress\_only\_internet\_gateway\_ids)| The ID of the egress-only internet gateway.       | `egress_only_internet_gateway_id`|
| routes(gateway\_ids)                       | The ID of a gateway attached to your VPC.          | `gateway_id`                    |
| routes(instance\_ids)                      | The ID of a NAT instance in your VPC.              | `instance_id`                   |
| routes(local\_gateway\_ids)                | The ID of the local gateway.                       | `instance_owner_id`             |
| routes(nat\_gateway\_ids)                  | The ID of a NAT gateway.                           | `nat_gateway_id`                |
| routes(network\_interface\_ids)            | The ID of the network interface.                   | `network_interface_id`          |
| routes(transit\_gateway\_ids)              | The ID of a transit gateway.                       | `transit_gateway_id`            |
| routes(vpc\_peering\_connection\_ids)      | The ID of a VPC peering connection.                | `vpc_peering_connection_id`     |
| routes(instance\_owner\_ids)               | The owner ID of a NAT instance in your VPC.        | `instance_owner_id`             |
| routes(origins)                            | Describes how the route was created.               | `origin`                        |
| routes(states)                             | The state of the route.                            | `state`                         |
| route_table_association_ids                | List of associated route table association IDs     | `route_table_association_ids`   |
| association_subnet_ids                     | List of all association states(`associated`, `failed`, `disassociated`) subnet IDs | `association_subnet_ids` |
| associated_subnet_ids                      | List of associated subnet IDs                      | `associated_subnet_ids`         |
| association_gateway_ids                    | List of all association states(`associated`, `failed`, `disassociated`) gateway IDs | `association_gateway_ids` |
| associated_gateway_ids                     | List of associated gateway IDs                     | `associated_gateway_ids`        |
| association_states                         | List of all association states(`associated`, `failed`, `disassociated`) | `association_states` |
| main                                       | flag to indicate the main route table              | `main`                          |

## Examples

### Confirm that a route table exists.

    describe aws_route_tables do
      its('vpc_ids') { should include 'VPC_ID' }
    end

### Confirm a route table exists.

    describe aws_route_tables do
      its('route_table_ids') { should include 'ROUTE_TABLE_ID' }
    end

### Confirm a destination_cidr_blocks is there in the routes.

    describe aws_route_tables do
      its('destination_cidr_blocks') { should include "IPV4_CIDR_BLOCK" }
    end

### Ensure subnet ID of interest is associated 

    describe aws_route_tables do
      its('associated_subnet_ids') { should include 'SUBNET_ID' }
    end

### Filter only main route tables

    describe aws_route_tables.where(main: true) do
      it { should exist }
    end

### Filter all failed associations

    describe aws_route_tables.where{ association_states.include?('associated') } do
      it { should exist }
    end

## Matchers

### exist

The control will pass if the describe returns at least one result.

Use `should` to test the entity should not exist.

    describe aws_route_tables do
      it { should exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeRouteTablesResult` action with `Effect` set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
