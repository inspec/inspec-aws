+++
title = "aws_vpc_endpoint_services resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_vpc_endpoint_services"
identifier = "inspec/resources/aws/aws_vpc_endpoint_services resource"
parent = "inspec/resources/aws"
+++

Use the `aws_vpc_endpoint_services` InSpec audit resource to test the properties of all AWS VPC Endpoint Services.
To audit a single endpoint service, use the `aws_vpc_endpoint_service` (singular) resource.

## Syntax

An `aws_vpc_endpoint_services` resource block collects a group of VPC endpoint services' descriptions and tests the group.

```ruby
describe aws_vpc_endpoint_services
  it { should exist }
end
```

## Properties

`service_names`
: The Amazon Resource Names (ARN) of the services.

: **Field**: `service_name`

`service_ids`
: The IDs of the endpoint services.

: **Field**: `service_id`

`service_types`
: The types of services.

: **Field**: `service_type`

`availability_zones`
: The Availability Zones in which the services are available.

: **Field**: `availability_zones`

`owners`
: The AWS account IDs of the service owners.

: **Field**: `owner`

`base_endpoint_dns_names`
: The DNS names for the service.

: **Field**: `base_endpoint_dns_names`

`private_dns_name`
: The private DNS name for the service.

: **Field**: `private_dns_name`

`vpc_endpoint_policy_supported`
: Whether the service supports endpoint policies. Valid values: `true` or `false`.

: **Field**: `vpc_endpoint_policy_supported`

`acceptance_required`
: Whether VPC endpoint connection requests to the service must be accepted by the service owner. Valid values: `true` or `false`.

: **Field**: `acceptance_required`

`manages_vpc_endpoints`
: Whether the service manages its VPC endpoints. Valid values: `true` or `false`.

: **Field**: `manages_vpc_endpoints`

`tags`
: The tags assigned to the service.

: **Field**: `tags`

`private_dns_name_verification_states`
: The verification states of the VPC endpoint service.

: **Field**: `private_dns_name_verification_states`

## Examples

Ensure that exactly three VPC endpoint services exist:

```ruby
describe aws_vpc_endpoint_services do
  its('count') { should eq 3 }
end
```

Filter all services in `us-east-2a` availability_zones:

```ruby
describe aws_vpc_endpoint_services.where{ availability_zones.include?('us-east-2a') } do
    it { should exist }
end
```

Filter all service where acceptance is required from the service owner:

```ruby
describe aws_vpc_endpoint_services.where(acceptance_required: true) do
    it { should exist }
end
```

Filter all static if it manages its vpc endpoints:

```ruby
describe aws_vpc_endpoint_services.where(manages_vpc_endpoints: true) do
    it { should exist }
end
```

Filter all private dns name verification states:

```ruby
describe aws_vpc_endpoint_services.where(private_dns_name_verification_states: 'verified') do
    it { should exist }
end
```

Request all the service names and check if endpoint policies are supported:

```ruby
aws_vpc_endpoint_services.service_names.each do |service_name|
  describe aws_vpc_endpoint_service(service_name: service_name) do
    it { should be_vpc_endpoint_policy_supported }
  end
end
```

## Matchers

For the complete list of available matchers, visit [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the 'describe' method returns at least one result.

```ruby
describe aws_vpc_endpoint_services.where( PROPERTY: VALUE) do
  it { should exist }
end
```

Use `should_not` to test an entity that should not exist.

```ruby
describe aws_vpc_endpoint_services.where( PROPERTY: VALUE) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeVpcEndpointServicesResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for VPC endpoint services](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-policy-examples.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
