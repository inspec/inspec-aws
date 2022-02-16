---
title: About the aws_route53_record_set Resource
platform: aws
---

# aws\_route53\_record\_set

Use the `aws_route53_record_set` InSpec audit resource to test properties of a single specific AWS Route53 record set.

The `AWS::Route53::RecordSet` resource specifies information about the record that you want to create.

## Syntax

Ensure that a record exists.

    describe aws_route53_record_set(hosted_zone_id: 'HOSTED_ZONE_ID', start_record_name: 'RECORD_SET_NAME') do
      it { should exist }
    end

## Parameters

`hosted_zone_id` _(required)

The ID of the hosted zone that contains the resource record sets that you want to list.

`start_record_name` _(required)_

The name of the record set.

For additional information, see the [AWS documentation on AWS Route53 Record Set](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-recordset.html).

## Properties

| Property | Description |
| :---: | :--- |
| name | The name of a record in the specified hosted zone. |
| type | The DNS record type.  |
| set_identifier | In a group of resource record sets that have the same name and type, the value of SetIdentifier must be unique for each resource record set. |
| weight | The weight element for every weighted resource record set. |
| region | The Amazon EC2 Region of the record set. |
| geo_location (continent_code) | The two-letter code for the continent. Amazon Route 53 supports the following continent codes: `AF`: Africa, `AN`: Antarctica, `AS`: Asia, `EU`: Europe, `OC`: Oceania, `NA`: North America, `SA`: South America. |
| geo_location (country_code) | The [two-letter code for a country](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). |
| geo_location (subdivision_code) | The [two-letter code for a state](https://pe.usps.com/text/pub28/28apb.htm) of the United States. |
| failover | The failover configuration of resource record set. Valid values are `PRIMARY` and `SECONDARY`. |
| multi_value_answer | Whether the resource is a Multivalue answer resource record set. Valid values: `true` or `false`. |
| ttl | The resource record cache time to live (TTL), in seconds. |
| resource_records | Information about the resource records to act upon. |
| alias_target (hosted_zone_id) | Alias resource record sets only: The hosted zone ID of the resource. |
| alias_target (dns_name) | Alias resource record sets only: The applicable domain name for your API. |
| alias_target (evaluate_target_health) | Applies only to alias, failover alias, geolocation alias, latency alias, and weighted alias resource record sets: When `EvaluateTargetHealth` is `true`, an alias resource record set inherits the health of the referenced AWS resource, such as an ELB load balancer or another resource record set in the hosted zone. Valid values: `true` or `false`. |
| health_check_id | The ID of a health check. |
| traffic_policy_instance_id | The ID of the traffic policy instance. When you create a traffic policy instance, Amazon Route 53 automatically creates a resource record set. `TrafficPolicyInstanceId` is the ID of the traffic policy instance that Route 53 created this resource record set for. |

## Examples

### Ensure a record is available.

    describe aws_route53_record_set(hosted_zone_id: 'HOSTED_ZONE_ID', start_record_name: 'RECORD_SET_NAME') do
      its('name') { should eq 'RECORD_SET_NAME' }
    end

### Ensure that the failover is `PRIMARY`.

    describe aws_route53_record_set(hosted_zone_id: 'HOSTED_ZONE_ID', start_record_name: 'RECORD_SET_NAME') do
        its('failover') { should eq 'PRIMARY' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_route53_record_set(hosted_zone_id: 'HOSTED_ZONE_ID', start_record_name: 'RECORD_SET_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_route53_record_set(hosted_zone_id: 'HOSTED_ZONE_ID', start_record_name: 'RECORD_SET_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the record name is available.

    describe aws_route53_record_set(hosted_zone_id: 'HOSTED_ZONE_ID', start_record_name: 'RECORD_SET_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Route53:Client:ListResourceRecordSetsResponse` action with `Effect` set to `Allow`.
