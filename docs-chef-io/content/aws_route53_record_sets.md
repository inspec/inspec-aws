+++
title = "aws_route53_record_sets resource"

draft = false


[menu.aws]
title = "aws_route53_record_sets"
identifier = "inspec/resources/aws/aws_route53_record_sets resource"
parent = "inspec/resources/aws"
+++

Use the `aws_route53_record_sets` InSpec audit resource to test properties of multiple AWS Route53 record sets.

The `AWS::Route53::RecordSet` type can be used as a standalone resource or as an embedded property in the `AWS::Route53::RecordSetGroup` type.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Route53 Record Set](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-recordset.html).

## Syntax

Ensure that a record exists.

```ruby
describe aws_route53_record_sets(hosted_zone_id: 'HOSTED_ZONE_ID') do
  it { should exist }
end
```

## Parameters

`hosted_zone_id` _(required)_

: The ID of the hosted zone that contains the resource record sets that you want to get.

## Properties

`names`
: The name of a record in the specified hosted zone.

: **Field**: `name`

`types`
: The DNS record type.

: **Field**: `type`

`set_identifiers`
: In a group of resource record sets that have the same name and type, the value of SetIdentifier must be unique for each resource record set.

: **Field**: `set_identifier`

`weights`
: The weight element for every weighted resource record set.

: **Field**: `weight`

`regions`
: The Amazon EC2 Region of the record set.

: **Field**: `region`

`geo_locations`
: The geo location of the record set.

: **Field**: `geo_location`

`failovers`
: The failover configuration of resource record set. Valid values are `PRIMARY` and `SECONDARY`.

: **Field**: `failover`

`multi_value_answers`
: Whether a resource is a Multivalue answer resource record set. Valid values: `true` or `false`.

: **Field**: `multi_value_answer`

`ttls`
: The resource record cache time to live (TTL), in seconds.

: **Field**: `ttl`

`resource_records`
: Information about the resource records to act upon.

: **Field**: `resource_record`

`alias_targets`
: The alias target of the record set.

: **Field**: `alias_target`

`health_check_ids`
: The IDs of a health check.

: **Field**: `health_check_id`

`traffic_policy_instance_ids`
: The ID of the traffic policy instance. When you create a traffic policy instance, Amazon Route 53 automatically creates a resource record set. `TrafficPolicyInstanceId` is the ID of the traffic policy instance that Route 53 created this resource record set for.

: **Field**: `traffic_policy_instance_id`

## Examples

Ensure a record name is available:

```ruby
describe aws_route53_record_sets(hosted_zone_id: 'HOSTED_ZONE_ID') do
  its('names') { should include 'RECORD_SET_NAME' }
end
```

Ensure that the failover of a record set is configured to `PRIMARY`:

```ruby
describe aws_route53_record_sets(hosted_zone_id: 'HOSTED_ZONE_ID') do
    its('failovers') { should include 'PRIMARY' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_route53_record_sets(hosted_zone_id: 'HOSTED_ZONE_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_route53_record_sets(hosted_zone_id: 'HOSTED_ZONE_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Route53:Client:ListResourceRecordSetsResponse" %}}
