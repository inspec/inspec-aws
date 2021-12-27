---
title: About the aws_route53_record_sets Resource
platform: aws
---

# aws_route53_record_sets

Use the `aws_route53_record_sets` InSpec audit resource to test properties of multiple AWS Route53 record sets.

The `AWS::Route53::RecordSet` resource specifies information about the record that you want to create.

## Syntax

Ensure that a record exists.

    describe aws_route53_record_sets(hosted_zone_id: 'HOSTED_ZONE_ID') do
      it { should exist }
    end

## Parameters

`hosted_zone_id` _(required)_

For additional information, see the [AWS documentation on AWS Route53 Record Set](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-recordset.html).

## Properties

| Property | Description|
| --- | --- |
| names | The name of a record in the specified hosted zone. |
| types | The DNS record type.  |
| set_identifiers | In a group of resource record sets that have the same name and type, the value of SetIdentifier must be unique for each resource record set. |
| weights | The weight element for every weighted resource record set. |
| regions | The Amazon EC2 Region of the record set. |
| geo_locations | The geo location of the record set. |
| failovers | The failover configuration of resource record set. Valid values are `PRIMARY` and `SECONDARY`. |
| multi_value_answers |  Whether a resource is a Multivalue answer resource record set. Valid values: `true` or `false`. |
| ttls | The resource record cache time to live (TTL), in seconds. |
| resource_records | Information about the resource records to act upon. |
| alias_targets | The alias target of the record set. |
| health_check_ids | The IDs of a health check. |
| traffic_policy_instance_ids | The ID of the traffic policy instance. When you create a traffic policy instance, Amazon Route 53 automatically creates a resource record set. `TrafficPolicyInstanceId` is the ID of the traffic policy instance that Route 53 created this resource record set for. |


## Examples

### Ensure a record name is available.

    describe aws_route53_record_sets(hosted_zone_id: 'HOSTED_ZONE_ID') do
      its('names') { should include 'RECORD_SET_NAME' }
    end

### Ensure that the failover of a record set is configured to `PRIMARY`.

    describe aws_route53_record_sets(hosted_zone_id: 'HOSTED_ZONE_ID') do
        its('failovers') { should include 'PRIMARY' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_route53_record_sets(hosted_zone_id: 'HOSTED_ZONE_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_route53_record_sets(hosted_zone_id: 'HOSTED_ZONE_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the record name is available.

    describe aws_route53_record_sets(hosted_zone_id: 'HOSTED_ZONE_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Route53:Client:ListResourceRecordSetsResponse` action with `Effect` set to `Allow`.
