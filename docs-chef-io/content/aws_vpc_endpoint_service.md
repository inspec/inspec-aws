+++
title = "aws_vpc_endpoint_service resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_vpc_endpoint_service"
identifier = "inspec/resources/aws/aws_vpc_endpoint_service resource"
parent = "inspec/resources/aws"
+++

Use the `aws_vpc_endpoint_service` InSpec audit resource to test the properties of a single AWS VPC endpoint service.

## Syntax

An `aws_vpc_endpoint_service` resource block declares the tests for a single AWS VPC endpoint service by `service_name`.

```ruby
describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
  it { should exist }
end
```

## Parameters

`service_name` _(required)_

: The name of the AWS VPC endpoint service.

: The AWS VPC endpoint service name is required.
  It should be passed as a `service_name: 'value'` key-value entry in a hash.

## Properties

`service_name`
: The Amazon Resource Name (ARN) of the service.

`service_id`
: The ID of the endpoint service.

`service_type`
: The type of service.

`availability_zones`
: The Availability Zones in which the service is available.

`owner`
: The AWS account ID of the service owner.

`base_endpoint_dns_names`
: The DNS names for the service.

`private_dns_name`
: The private DNS name for the service.

## Examples

Test whether VPC endpoint service exists:

```ruby
describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
    it { should exist }
end
```

Test whether the ID of the attached VPC is `vpce-svc-04deb776dc2b8e67f`:

```ruby
describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
    its('service_id') { should eq 'vpce-svc-04deb776dc2b8e67f' }
end
```

Test whether the service_type of the endpoint service is :

```ruby
describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
    its('service_type') { should eq 'Interface' }
end
```

Test whether the availability_zones include a zone of interest:

```ruby
describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
    its('availability_zones') { should include 'us-east-2a' }
end
```

Test whether the base endpoint dns_names include a dns of interest:

```ruby
describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
    its('base_endpoint_dns_names') { should eq 'vpce-svc-04deb776dc2b8e67f.us-east-2.vpce.amazonaws.com' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For the complete list of available matchers,visit [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

```ruby
describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
    it { should exist }
end
```

### be_interface

```ruby
describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
    it { should be_interface }
end
```

### be_vpc_endpoint_policy_supported

```ruby
describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
    it { should be_vpc_endpoint_policy_supported }
end
```

### be_acceptance_required

```ruby
describe aws_vpc_endpoint_service(service_name: 'tgw-rtb-08acd74550c99e911', cidr_block: '0.0.0.0/16') do
    it { should be_acceptance_required }
end
```

### be_manages_vpc_endpoints

```ruby
describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
    it { should be_manages_vpc_endpoints }
end
```

### be_private_dns_name_verified

```ruby
describe aws_vpc_endpoint_service(service_name: 'tgw-rtb-08acd74550c99e911', cidr_block: '0.0.0.0/17') do
    it { should be_private_dns_name_verified }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeVpcEndpointServicesResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for VPC endpoint services](https://docs.amazonaws.cn/en_us/vpc/latest/userguide/vpc-policy-examples.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
