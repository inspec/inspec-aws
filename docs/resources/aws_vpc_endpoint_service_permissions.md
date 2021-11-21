---
title: About the aws_vpc_endpoint_service_permissions Resource
platform: aws
---

# service_id

Use the `aws_vpc_endpoint_service_permissions` InSpec audit resource to test the properties of all Amazon VPC endpoint service permissions. To audit a single AWS VPC Endpoint service, use the `aws_vpc_endpoint_service_permission` (singular) resource.

## Syntax

An `aws_vpc_endpoint_service_permissions` resource block collects a group of AWS VPC endpoint service permissions descriptions and then tests that group.

    describe aws_vpc_endpoint_service_permissions(service_id: 'VPC_SERVICE_ID')
      it { should exist }
    end

### Parameters

The AWS VPC endpoint service ID is required.

#### service_id _(required)_

The ID of the VPC endpoint service:

- must contain between 1 and 50 alphanumeric characters or hyphens
- should start with `vpce-svc-`
- cannot end with a hyphen or contain two consecutive hyphens

For example, `vpce-svc-04deb776dc2b8e67f`.

It can be passed as a `service_id: 'value'` key-value entry in a hash.

## Properties

| Property           | Description                              |        Fields                       |
| ---                | ---                                      | ---                                 |
| principal_types   | List of types of principal.              | `principal_type`                    |
| principals         | List of the Amazon Resource Name (ARN) of the principal. | `principal`         |
## Examples

### Ensure that exactly three AWS VPC endpoint service permissions exist

    describe aws_vpc_endpoint_service_permissions(service_id: 'VPC_SERVICE_ID') do
      its('count') { should eq 3 }
    end

### Request the principals of all AWS VPC endpoint service permissions, then test in-depth using `aws_vpc_endpoint_service_permission`.

    aws_vpc_endpoint_service_permissions(service_id: 'VPC_SERVICE_ID').principals.each do |principal|
      describe aws_vpc_endpoint_service_permission(service_id: 'VPC_SERVICE_ID', principal: 'PRINCIPAL_ARN') do
        it { should exists }
        it { should be_principal_type_user }
      end
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the 'describe' method returns at least one result.

    describe aws_vpc_endpoint_service_permissions(service_id: 'VPC_SERVICE_ID').where( PROPERTY: VALUE) do
      it { should exist }
    end

Use `should_not` to test an entity that should not exist.

    describe aws_vpc_endpoint_service_permissions(service_id: 'VPC_SERVICE_ID').where( PROPERTY: VALUE) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeVpcEndpointServicePermissionsResult` action with `Effect` set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon VPC endpoint service permissions](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVpcEndpointServicePermissions.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
