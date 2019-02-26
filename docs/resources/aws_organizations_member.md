---
title: About the aws_organizations_member Resource
---

# aws\_organizations\_member

Use the `aws_organizations_member` InSpec audit resource to test the current AWS Account being used within organization.

## Syntax

An `aws_organizations_member` resource block tests if the current AWS Account is the Master Account.
 
The `master` matcher will return `true` or `false` accordingly. 
You may also verify that the `master_account_id` and `master_account_arn` properties match known values.

If the current AWS Account _**is**_ the Master Account, you may also access properties of that account.
  
        describe aws_organizations_member do
            ...
        end
<br>

## Examples

The following examples show how to use this InSpec audit resource.

    # Ensure you are a child account with a certain ID for the top level account.
    
        describe aws_organizations_member do
          it                       { should_not be_master }
          its('master_account_id') { should cmp '56845218745' }
        end
    
    # Ensure you are the top level account, with the right name and email associated.
        
        describe aws_organizations_member do
          it                   { should be_master }
          its('account_name')  { should eq 'MyAWSMasterAccount' }
          its('account_email') { should eq 'aws.admin@org.com' }
        end

<br>

## Properties

* `master_account_id` - The ID of the AWS Organizations Master Account
* `master_account_arn` - The ARN of the AWS Organizations Master Account

_**If the current Account is the Master Account, the following properties are also available:**_
* `account_id`      - The ID of the current Account.
* `account_arn`     - The ARN of the current Account. 
* `account_name`    - The Name of the current Acccount.
* `account_email`   - The Email address associated with the current Account. 

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### be\_master

The `be_master` matcher tests if the account is a 'master' AWS Account.

    it { should_not be_master }
