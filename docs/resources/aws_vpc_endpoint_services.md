---
title: About the aws_vpc_endpoint_services Resource
platform: aws
---

# aws\_transit\_gateway\_routes

Use the `aws_vpc_endpoint_services` InSpec audit resource to test the properties of all Route for a AWS VPC Endpoint Services.
To audit a single gateway route, use the `aws_vpc_endpoint_service` (singular) resource.

## Syntax

An `aws_vpc_endpoint_services` resource block collects a group of transit gateway routes' descriptions and then tests that group.

    describe aws_transit_gateway_routes
      it { should exist }
    end

### Parameters

The AWS VPC Endpoint Services ID is required.


#### transit\_gateway\_route\_table\_id _(required)_

The ID of the AWS VPC Endpoint Services:

- must contain between 1 and 50 alphanumeric characters or hyphens
- should start with `tgw-rtb-`
- cannot end with a hyphen or contain two consecutive hyphens

It should be passed as a `transit_gateway_route_table_id: 'value'` key-value entry in a hash.

#### exact\_match

The exact match of the CIDR block used for destination matches. It could be passed as a `exact_match: 'value'` key-value entry in a hash.

#### longest\_prefix\_match

The longest prefix that matches the route. It could be passed as a `longest_prefix_match: 'value'` key-value entry in a hash.

#### subnet\_of\_match

The routes with a subnet that match the specified CIDR filter. It could be passed as a `subnet_of_match: 'value'` key-value entry in a hash.

#### supernet\_of\_match

The routes with a CIDR that encompass the CIDR filter. For example, if you have 10.0.1.0/29 and 10.0.1.0/31 routes in your route table and you specify supernet-of-match as 10.0.1.0/30, then the result returns 10.0.1.0/29.
It could be passed as a `supernet_of_match: 'value'` key-value entry in a hash.

## Properties

|Property                  | Description                                                | Field Name     |
| ---                      | ---                                                        | ---            |
|cidr_blocks               | All the CIDR blocks used for destination matches.          | cidr_block     |
|prefix_list_ids           | The IDs of the prefix list used for destination matches.   | prefix_list_id |
|types                     | The type of all routes. Valid values: `propagated` or `static`. | type      |
|states                    | The state of the routes. Valid values: `active` or `blackhole`. | state     |
|static                    | Boolean flag to determine whether the route type is static.| static         |
|propagated                | Boolean flag to determine whether the route type is propagated.| propagated |
|active                    | Boolean flag to determine whether the route state is active.| active        |
|blackhole                 | Boolean flag to determine whether the route state is blackhole.| blackhole  |
|attachment_ids            | The id of the transit gateway attachment.                  | attachment_id  |
|attachment_resource_ids   | The resource IDs of all the transit gateway attachments. Identifiers of relevant resource types.| attachment_resource_id |
|attachment_resource_types | The attachment resource type. Valid values are `vpc`, `vpn`, `direct-connect-gateway`, `peering` `connect`. | attachment_resource_type |
|attached_vpc_ids          | The VPC IDs of all the transit gateway attachments.        | attached_vpc_id |

## Examples

### Ensure that exactly three transit gateway routes exist

    describe aws_transit_gateway_route do
      its('count') { should eq 3 }
    end

### Filter all transit gateway routes whose CIDR block matches `0.0.0.0/16`

    describe aws_vpc_endpoint_services(transit_gateway_route_table_id: 'tgw-rtb-08acd74550c99e589', exact_match: '0.0.0.0/16') do
        it { should exist }
    end

    describe aws_vpc_endpoint_services.where(cidr_block: '0.0.0.0/16') do
        it { should exist }
    end

### Filter all static transit gateway routes

    describe aws_vpc_endpoint_services.where(static: true) do
        it { should exist }
    end

### Filter all static transit gateway blackhole routes

    describe aws_vpc_endpoint_services.where(static: true, blackhole: true) do
        it { should exist }
    end

### Filter all transit gateway routes with destination CIDR blocks matching `10.3.0.0/18`

    describe aws_vpc_endpoint_services(transit_gateway_route_table_id: 'tgw-rtb-08acd74550c99e589', supernet_of_match: 10.3.0.0/19) do
        it { should exist }
        its('cidr_blocks') { should include '10.3.0.0/18' }
    end

### Request the CIDR blocks of all transit gateway routes, then test in-depth using `aws_transit_gateway_route`.

    aws_vpc_endpoint_services.cidr_blocks.each do |cidr_block|
      describe aws_transit_gateway_route(transit_gateway_route_table_id: 'tgw-rtb-08acd74550c99e589', cidr_block: cidr_block) do
        it { should exist }
      end
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the 'describe' method returns at least one result.

    describe aws_vpc_endpoint_services(transit_gateway_route_table_id: <value>).where( <property>: <value>) do
      it { should exist }
    end

Use `should_not` to test an entity that should not exist.

    describe aws_vpc_endpoint_services(transit_gateway_route_table_id: <value>).where( <property>: <value>) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeTransitGatewayRouteTables` action set to `allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ElastiCache](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-policy-examples.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).