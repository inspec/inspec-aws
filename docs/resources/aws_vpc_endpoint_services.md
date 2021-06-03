---
title: About the aws_vpc_endpoint_services Resource
platform: aws
---

# aws\_vpc\_endpoint\_services

Use the `aws_vpc_endpoint_services` InSpec audit resource to test the properties of all Route for a AWS VPC Endpoint Services.
To audit a single endpoint service, use the `aws_vpc_endpoint_service` (singular) resource.

## Syntax

A `aws_vpc_endpoint_services` resource block collects a group of VPC endpoint services' descriptions and tests the group.

    describe aws_vpc_endpoint_services
      it { should exist }
    end

## Properties

|Property                           | Description                                                | Field Name     |
| ---                               | ---                                                        | ---            |
| service_names                     | The List Amazon Resource Names (ARN) of all the services.  | `service_name`     |
| service_ids                       | The IDs of all the endpoint service.                       | `service_id` |
| service_types                     | List of all the types of service.                          | `service_type`      |
| availability_zones                | List of all the Availability Zones in which the services are available. | `availability_zones`     |
| owners                            | The AWS account IDs of the service owners.                 | `owner`         |
| base_endpoint_dns_names           | The DNS names for the service.                             | `base_endpoint_dns_names` |
| private_dns_name                  | The private DNS name for the service.                      | `private_dns_name`        |
| vpc_endpoint_policy_supported     | List of boolean flags to indicate whether the service supports endpoint policies. | `vpc_endpoint_policy_supported`  |
| acceptance_required               | List of boolean flags to indicate whether VPC endpoint connection requests to the service must be accepted by the service owner.| `acceptance_required`  |
| manages_vpc_endpoints             | List of boolean flags that indicates whether the service manages its VPC endpoints. | `manages_vpc_endpoints` |
| tags                              | List of all tags assigned to the service.                  | `tags` |
| private_dns_name_verification_states | The verification states of the VPC endpoint service.    | `private_dns_name_verification_states` |

## Examples

### Ensure that exactly three VPC endpoint services exist

    describe aws_vpc_endpoint_services do
      its('count') { should eq 3 }
    end

### Filter all services in `us-east-2a` availability_zones

    describe aws_vpc_endpoint_services.where{ availability_zones.include?('us-east-2a') } do
        it { should exist }
    end

### Filter all service where acceptance is required from the service owner

    describe aws_vpc_endpoint_services.where(acceptance_required: true) do
        it { should exist }
    end

### Filter all static if it manages its vpc endpoints

    describe aws_vpc_endpoint_services.where(manages_vpc_endpoints: true) do
        it { should exist }
    end

### Filter all private dns name verification states

    describe aws_vpc_endpoint_services.where(private_dns_name_verification_states: 'verified') do
        it { should exist }
    end

### Request all the service names and check if endpoint policies are supported.

    aws_vpc_endpoint_services.service_names.each do |service_name|
      describe aws_vpc_endpoint_service(service_name: service_name) do
        it { should be_vpc_endpoint_policy_supported }
      end
    end

## Matchers

For the complete list of available matchers, visit [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the 'describe' method returns at least one result.

    describe aws_vpc_endpoint_services.where( <property>: <value>) do
      it { should exist }
    end

Use `should_not` to test an entity that should not exist.

    describe aws_vpc_endpoint_services.where( <property>: <value>) do
      it { should_not exist }
    end

## AWS Permissions

The get the AWS permissions for the [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal), you need the `ec2:DescribeVpcEndpointServices` action set to `allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ElastiCache](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-policy-examples.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
