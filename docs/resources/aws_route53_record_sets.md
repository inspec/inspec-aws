---
title: About the aws_route53_record_sets Resource
platform: aws
---

# aws\_route53\_record\_sets

Use the `aws_route53_record_sets` InSpec audit resource to test properties of a plural Athena Work Groups.

The AWS::Route53::RecordSet resource specifies information about the record that you want to create.

## Syntax

Ensure that a record exists.

    describe aws_route53_record_sets(hosted_zone_id: 'ResourceId') do
      it { should exist }
    end

## Parameters

`hosted_zone_id` _(required)_

For additional information, see the [AWS documentation on AWS Route53 Record Set](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-recordset.html).

## Properties

| Property | Description|
| --- | --- |
| names | The name of the record that you want to create, update, or delete. |
| types | The DNS record type.  |
| set_identifiers | In a group of resource record sets that have the same name and type, the value of SetIdentifier must be unique for each resource record set. |
| weights | The Weight element for every weighted resource record set. |
| regions | The region of the record set. |
| geo_locations | The geo location of the record set. |
| failovers | To configure failover, you add the Failover element to two resource record sets. For one resource record set, you specify PRIMARY as the value for Failover ; for the other resource record set, you specify SECONDARY. |
| multi_value_answers | Multivalue answer resource record sets only : To route traffic approximately randomly to multiple resources, such as web servers, create one multivalue answer record for each resource and specify true for MultiValueAnswer. |
| ttls | The resource record cache time to live (TTL), in seconds. |
| resource_records | Information about the resource records to act upon. |
| alias_targets | The alias target of the record set. |
| health_check_ids | If you want Amazon Route 53 to return this resource record set in response to a DNS query only when the status of a health check is healthy, include the HealthCheckId element and specify the ID of the applicable health check. |
| traffic_policy_instance_ids | When you create a traffic policy instance, Amazon Route 53 automatically creates a resource record set. TrafficPolicyInstanceId is the ID of the traffic policy instance that Route 53 created this resource record set for. |


## Examples

### Ensure a record name is available.
    describe aws_route53_record_sets(hosted_zone_id: 'ResourceId') do
      its('names') { should include 'DNSName' }
    end

### Ensure that the failover is `PRIMARY` or `SECONDARY`.
    describe aws_route53_record_sets(hosted_zone_id: 'ResourceId') do
        its('failovers') { should include 'PRIMARY' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_route53_record_sets(hosted_zone_id: 'ResourceId') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_route53_record_sets(hosted_zone_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the record name is available.

    describe aws_route53_record_sets(hosted_zone_id: 'ResourceId') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `cloudwatchlogs:client:list_resource_record_sets` action with `Effect` set to `Allow`.