---
title: About the aws_waf_ip_set resource
platform: aws
---

# aws_waf_ip_set

Use the `aws_waf_ip_set` Chef InSpec audit resource to test the properties of a single AWS Web Application Firewall (WAF) IP set.

## Syntax

Ensure that IP set exists.

    describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
      it { should exist }
    end

## Parameters

`ip_set_id` _(required)_

The ID for an IP set.

For additional information, see the [AWS documentation on AWS WAF IPSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-ipset.html).

## Properties

| Property | Description |
| --- | --- |
| ip_set_id | The IPSetId for an IP set. |
| name | A friendly name or description of the IP set. |
| ip_set_descriptors | The IP address type (IPV4 or IPV6 ) and the IP address range (in CIDR notation) that web requests originate from. |
| ip_set_descriptors_types | Specify IPV4 or IPV6. |
| ip_set_descriptors_values | Specify an IPv4 address by using CIDR notation. |

## Examples

### Ensure an IP set is available.

    describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
      its('ip_set_id') { should eq 'IP_SET_ID' }
    end

### Ensure an IP set name is available.

    describe aws_waf_ip_set(ip_set_id: 'IP_SET_ID') do
        its('name') { should eq 'IP_SET_NAME' }
    end

### Ensure an IP set descriptors type is `IPV4`.

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
