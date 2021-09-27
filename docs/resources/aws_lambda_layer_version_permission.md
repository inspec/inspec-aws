---
title: About the aws_lambda_layer_version_permission Resource
platform: aws
---

# aws_lambda_layer_version_permission

Use the `aws_lambda_layer_version_permission` InSpec audit resource to test properties of a single specific AWS Lambda LayerVersionPermission.

The AWS::Lambda::LayerVersionPermission resource adds permissions to the resource-based policy of a version of an Lambda layer.

## Syntax

Ensure that the permission exists.

    describe aws_lambda_layer_version_permission(layer_name: 'LayerName', version_number: 'VersionNumber') do
      it { should exist }
    end

## Parameters

`layer_name` and `version_number` _(required)_

| Property | Description |
| --- | --- |
| layer_name | The name or Amazon Resource Name (ARN) of the layer. |
| version_number | The version number. |

For additional information, see the [AWS documentation on AWS CloudFront RealtimeLogConfig.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-realtimelogconfig.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| policy | The policy document. | policy |
| revision_id | A unique identifier for the current revision of the policy. | revision_id |

## Examples

### Ensure policy is available.
    describe aws_lambda_layer_version_permission(layer_name: 'LayerName', version_number: 'VersionNumber') do
      its('policy') { should eq 'Policy' }
    end

### Ensure a revision id is available.
    describe aws_lambda_layer_version_permission(layer_name: 'LayerName', version_number: 'VersionNumber') do
        its('revision_id') { should eq 'RevisionId' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_lambda_layer_version_permission(layer_name: 'LayerName', version_number: 'VersionNumber') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_lambda_layer_version_permission(layer_name: 'dummy', version_number: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_lambda_layer_version_permission(layer_name: 'LayerName', version_number: 'VersionNumber') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Lambda:Client:GetLayerVersionPolicyResponse` action with `Effect` set to `Allow`.