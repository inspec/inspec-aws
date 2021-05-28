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

|Property          | Description|
| ---              | --- |
|route\_table\_ids | The route table IDs |
|vpc\_ids          | The VPC IDs |
|entries           | Provides access to the raw results of the query, which can be treated as an array of hashes. |
| routes(carrier\_gateway\_ids) | The ID of the carrier gateway. |
| routes(destination\_cidr\_blocks) | The IPv4 CIDR block used for the destination match. |
| routes(destination\_ipv\_6\_cidr\_blocks) | The IPv6 CIDR block used for the destination match. |
| routes(destination\_prefix\_list\_ids) | The prefix of the AWS service. |
| routes(egress\_only\_internet\_gateway\_ids) | The ID of the egress-only internet gateway. |
| routes(gateway\_ids) | The ID of a gateway attached to your VPC. |
| routes(instance\_ids) | The ID of a NAT instance in your VPC. |
| routes(local\_gateway\_ids) | The ID of the local gateway. |
| routes(nat\_gateway\_ids) | The ID of a NAT gateway. |
| routes(network\_interface\_ids) | The ID of the network interface. |
| routes(transit\_gateway\_ids) | The ID of a transit gateway. |
| routes(vpc\_peering\_connection\_ids) | The ID of a VPC peering connection. |
| routes(instance\_owner\_ids) | The owner ID of a NAT instance in your VPC. |
| routes(origins) | Describes how the route was created. |
| routes(states) | The state of the route. |

## Examples

### Confirm that a route table exists.

    describe aws_route_tables do
      its('vpc_ids') { should include 'vpc-01625e36123456789' }
    end

### Confirm a route table exists.

    describe aws_route_tables do
      its('route_table_ids') { should include 'rtb-12345678' }
    end

### Confirm a destination_cidr_blocks is there in the routes.

    describe aws_route_tables do
      its('destination_cidr_blocks') { should include "10.0.0.0/27" }
    end


## Matchers

### exist

The control will pass if the describe returns at least one result.

Use `should` to test the entity should not exist.

    describe aws_route_tables do
      it { should exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescriberouteTables` action with `Effect` set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
