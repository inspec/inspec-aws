---
title: About the aws_vpc_endpoint_service_permission Resource
platform: aws
---

# aws_vpc_endpoint_service_permission

Use the `aws_vpc_endpoint_service_permission` InSpec audit resource to test the properties of a single AWS VPC endpoint service permission.

## Syntax

An `aws_vpc_endpoint_service_permission` resource block declares the tests for a single AWS VPC endpoint service permission by `service_id` and `principal`.

    describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
      it { should exist }
    end

### Parameters

The AWS VPC endpoint service ID is required.

#### service\_id _(required)_

The ID of the VPC endpoint service:

- must contain between 1 and 50 alphanumeric characters or hyphens
- should start with `vpce-svc-`
- cannot end with a hyphen or contain two consecutive hyphens

For example, `vpce-svc-04deb776dc2b8e67f`.

It can be passed as a `service_id: 'value'` key-value entry in a hash.

#### principal _(required)_

The ARN of the principal.
It can be passed as a `principal: 'value'` key-value entry in a hash.

## Properties

|Property        | Description |
| ---            | ---         |
| principal_type | The type of principal. |
| principal      | The Amazon Resource Name (ARN) of the principal. |

## Examples

### Test that a VPC endpoint service permission is available

    describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
        it { should exist }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).


### exist

    describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
        it { should exist }
    end

### Verify that a principal has a user type

    describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
        it { should be_principal_type_user }
    end

### Verify that a principal does not have an all type

    describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
        it { should_not be_principal_type_all }
    end

### Verify that a principal does not have an organization unit type

    describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
        it { should_not be_principal_type_organization_unit }
    end

### Verify that a principal does not have an account type

    describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
        it { should_not be_principal_type_account }
    end

### Verify that a principal does not have a role type

    describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'arn:aws:iam::AWS_ACCOUNT_ID:user/USER_NAME') do
        it { should_not be_principal_type_role }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeVpcEndpointServicePermissionsResult` action set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon VPC endpoint service permissions](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVpcEndpointServicePermissions.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
