---
title: About the aws_waf_web_acls resource
platform: aws
---

# aws_waf_web_acls

Use the `aws_waf_web_acls` InSpec audit resource to test the properties of multiple of AWS WAF WebACL.

The `AWS::WAFv2::WebACL` AWS resource defines a collection of rules to use to inspect and control web requests.

## Syntax

Ensure that web ACL exists.

    describe aws_waf_web_acls do
      it { should exist }
    end

## Parameters

No required parameters.

For additional information, see the [AWS documentation on the `AWS::WAFv2::WebACL` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-webacl.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| web_acl_ids | The unique identifier for the web ACL. | web_acl_id |
| names | The name of the web ACL. | name |

## Examples

### Ensure a web ACL is available.

    describe aws_waf_web_acls do
      its('web_acl_ids') { should include 'WEB_ACL_ID' }
    end

### Ensure a web ACL name is available..

    describe aws_waf_web_acls do
        its('names') { should include 'WEB_ACL_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_waf_web_acls do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_waf_web_acls do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_waf_web_acls do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `WAF:Client:ListWebACLsResponse` action with `Effect` set to `Allow`.
