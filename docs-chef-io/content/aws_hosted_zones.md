+++
title = "aws_hosted_zones resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_hosted_zones"
identifier = "inspec/resources/aws/aws_hosted_zones resource"
parent = "inspec/resources/aws"
+++

Use the `aws_hosted_zones` InSpec audit resource to test the properties of multiple AWS Route53 hosted zones.

The `AWS::Route53::HostedZone` creates a new public or private hosted zone.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::Route53::HostedZone` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53-hostedzone.html).

## Syntax

Ensure the hosted zones are available

```ruby
describe aws_hosted_zones do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: The ID that Amazon Route 53 assigned to the hosted zone when you created it.

: **Field**: `id`

`names`
: The name of the domain.

: **Field**: `name`

`caller_references`
: The value that you specified for CallerReference when you created the hosted zone.

: **Field**: `caller_reference`

`configs`
: A complex type that includes the Comment and PrivateZone elements.

: **Field**: `config`

`resource_record_set_counts`
: The number of resource record sets in the hosted zone.

: **Field**: `resource_record_set_count`

`linked_services`
: If the hosted zone was created by another service, the service that created the hosted zone.

: **Field**: `linked_service`

## Examples

**Ensure that there are more than one hosted zone.**

```ruby
describe aws_hosted_zones do
  its('count') { should >= 1 }
end
```

**Ensure a hosted zone is available.**

```ruby
describe aws_hosted_zones do
  its('ids') { should include 'HOSTED_ZONE_ID' }
end
```

**Ensure a hosted zone name is available.**

```ruby
describe aws_hosted_zones do
    its('names') { should include 'HOSTED_ZONE_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_hosted_zones do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_hosted_zones do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Route53:Client:ListHostedZonesResponse" %}}
