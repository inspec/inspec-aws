---
title: About the aws_route53_record_set Resource
platform: aws
---

# aws\_route53\_record\_set

Use the `aws_route53_record_set` InSpec audit resource to test properties of a single specific AWS Route53 Record Set.

The AWS::Route53::RecordSet resource specifies information about the record that you want to create.

## Syntax

Ensure that a record exists.

    describe aws_route53_record_set(hosted_zone_id: 'ResourceId', start_record_name: 'DNSName') do
      it { should exist }
    end

## Parameters

`hosted_zone_id start_record_name` _(required)_

For additional information, see the [AWS documentation on AWS Route53 Record Set](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-recordset.html).

## Properties

| Property | Description|
| --- | --- |
| name | The name of the record that you want to create, update, or delete. |
| type | The DNS record type.  |
| set_identifier | In a group of resource record sets that have the same name and type, the value of SetIdentifier must be unique for each resource record set. |
| weight | The Weight element for every weighted resource record set. |
| region | The region of the record set. |
| geo_location (continent_code) | The two-letter code for the continent. Amazon Route 53 supports the following continent codes: AF : Africa, AN : Antarctica, AS : Asia, EU : Europe, OC : Oceania, NA : North America, SA : South America. |
| geo_location (country_code) | The two-letter code for a country. |
| geo_location (subdivision_code) | The two-letter code for a state of the United States. |
| failover | To configure failover, you add the Failover element to two resource record sets. For one resource record set, you specify PRIMARY as the value for Failover ; for the other resource record set, you specify SECONDARY. |
| multi_value_answer | Multivalue answer resource record sets only : To route traffic approximately randomly to multiple resources, such as web servers, create one multivalue answer record for each resource and specify true for MultiValueAnswer. |
| ttl | The resource record cache time to live (TTL), in seconds. |
| resource_records | Information about the resource records to act upon. |
| alias_target (hosted_zone_id) | Alias resource record sets only: Information about the AWS resource, such as a CloudFront distribution or an Amazon S3 bucket, that you want to route traffic to. It specify the hosted zone ID for your API. |
| alias_target (dns_name) | Alias resource record sets only: Information about the AWS resource, such as a CloudFront distribution or an Amazon S3 bucket, that you want to route traffic to.  It specify the applicable domain name for your API. |
| alias_target (evaluate_target_health) | Alias resource record sets only: Information about the AWS resource, such as a CloudFront distribution or an Amazon S3 bucket, that you want to route traffic to. Applies only to alias, failover alias, geolocation alias, latency alias, and weighted alias resource record sets: When EvaluateTargetHealth is true , an alias resource record set inherits the health of the referenced AWS resource, such as an ELB load balancer or another resource record set in the hosted zone. |
| health_check_id | If you want Amazon Route 53 to return this resource record set in response to a DNS query only when the status of a health check is healthy, include the HealthCheckId element and specify the ID of the applicable health check. |
| traffic_policy_instance_id | When you create a traffic policy instance, Amazon Route 53 automatically creates a resource record set. TrafficPolicyInstanceId is the ID of the traffic policy instance that Route 53 created this resource record set for. |

## Examples

### Ensure a record is available.
    describe aws_route53_record_set(hosted_zone_id: 'ResourceId', start_record_name: 'DNSName') do
      its('name') { should eq 'DNSName' }
    end

### Ensure that the failover is `PRIMARY` or `SECONDARY`.
    describe aws_route53_record_set(hosted_zone_id: 'ResourceId', start_record_name: 'DNSName') do
        its('failover') { should eq 'PRIMARY' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_route53_record_set(hosted_zone_id: 'ResourceId', start_record_name: 'DNSName') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_route53_record_set(hosted_zone_id: 'dummy', start_record_name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the record name is available.

    describe aws_route53_record_set(hosted_zone_id: 'ResourceId', start_record_name: 'DNSName') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `cloudwatchlogs:client:list_resource_record_sets` action with `Effect` set to `Allow`.