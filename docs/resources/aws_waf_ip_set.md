---
title: About the aws_waf_ip_set resource
platform: aws
---

# aws_waf_ip_set

Use the `aws_waf_ip_set` InSpec audit resource to test the properties of the singular resource of AWS WAF IPSet.

## Syntax

Ensure that ip set exists.

    describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
      it { should exist }
    end

## Parameters

`ip_set_id` _(required)_

The IPSetId for an IPSet.

For additional information, see the [AWS documentation on AWS WAF IPSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-ipset.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| ip_set_id | The IPSetId for an IPSet. | ip_set_id |
| name | A friendly name or description of the IPSet. | name |
| ip_set_descriptors | The IP address type (IPV4 or IPV6 ) and the IP address range (in CIDR notation) that web requests originate from. | ip_set_descriptors |
| ip_set_descriptors_types | Specify IPV4 or IPV6. |  ip_set_descriptors (type) |
| ip_set_descriptors_values | Specify an IPv4 address by using CIDR notation. |  ip_set_descriptors (value) |

## Examples

### Ensure a ip set is available.

    describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
      its('ip_set_id') { should eq 'IP_SET_ID' }
    end

### Ensure a ip set name is available..

    describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
        its('name') { should eq 'WEB_ACL_NAME' }
    end

### Ensure a ip set descriptors type is `IPV4`.

    describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
        its('ip_set_descriptors_types') { should include 'IPV4' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `WAF:Client:GetIPSetResponse` action with `Effect` set to `Allow`.