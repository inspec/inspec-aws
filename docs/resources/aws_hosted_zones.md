---
title: About the aws_hosted_zones Resource
platform: aws
---

# aws_hosted_zones

Use the `aws_hosted_zones` InSpec audit resource to test the properties of multiple AWS Route53 hosted zones.

The `AWS::Route53::HostedZone` creates a new public or private hosted zone.

## Syntax

Ensure the hosted zones are available

    describe aws_hosted_zones do
      it { should exist }
    end

#### Parameters

This resource does not expect any parameters.

For additional information, see the [AWS documentation on the `AWS::Route53::HostedZone` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53-hostedzone.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| ids | The ID that Amazon Route 53 assigned to the hosted zone when you created it. | id |
| names | The name of the domain. | name |
| caller_references | The value that you specified for CallerReference when you created the hosted zone. | caller_reference |
| configs | A complex type that includes the Comment and PrivateZone elements. | config |
| resource_record_set_counts | The number of resource record sets in the hosted zone. | resource_record_set_count |
| linked_services | If the hosted zone was created by another service, the service that created the hosted zone. | linked_service |

## Examples

### Ensure that there are more than one hosted zone.

    describe aws_hosted_zones do
      its('count') { should >= 1 }
    end

### Ensure a hosted zone is available.

    describe aws_hosted_zones do
      its('ids') { should include 'HOSTED_ZONE_ID' }
    end

### Ensure a hosted zone name is available.

    describe aws_hosted_zones do
        its('names') { should include 'HOSTED_ZONE_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_hosted_zones do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_hosted_zones do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Route53:Client:ListHostedZonesResponse` action with `Effect` set to `Allow`.
