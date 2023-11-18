+++
title = "aws_billing_contact Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_billing_contact"
identifier = "inspec/resources/aws/aws_billing_contact Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_billing_contact` InSpec audit resource to test properties of the billing contact information associated with your account.

For additional information, including details on parameters and properties, see the [AWS documentation on the billing contact information associated with your account](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-update-contact-billing.html). Technical details on the data structure can be found for the [api documentation.](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Account/Client.html#get_contact_information-instance_method)

## Installation

{{% inspec_aws_install %}}

## Syntax

The `aws_billing_contact` resource allows the testing of the billing contact information associated with your account.

```ruby
describe aws_billing_contact do
  it { should exist }
end
```

## Parameters

This resources does not take any parameters at this time.

## Properties


`api_response` (Struct) 
: Returns the api response from our call to the aws api as a struct.

`raw_data` (Hash)
: Returns a transformed Hash of Strings of the data associated with the billing contact.

`aws_account_id` (String)
: 12-digit account ID number of the Amazon Web Services account associated with the billing contact.

`name` (String)
: Specifies the full name of the billing contact.

`title` (String)
: Specifies the full name of the billing contact.

`email_address` (String)
: Specifies the full name of the billing contact.

`phone_number` (String)
: Specifies the phone number associated with the billing contact.

## Examples

The following examples show how to use this InSpec audit resource.

**Test that a billing contact exists for the aws account.**

```ruby
describe aws_billing_contact do
  it { should exist }
end
```

**Test that the billing contact is set and the values for its full name and first address line are set as expected.**

```ruby
describe aws_billing_contact do
  it { should be_configured }
  its('name') { should cmp 'John Smith' }
  its('title') { should cmp 'Money Guy' }
end
```

## Matchers

{{% inspec_matchers_link %}}

### exist (alias of configured)

Use `should` to test if the aws account has a billing contact configured.

```ruby
it { should exist }
```

### configured

The `configured` matcher tests if the described billing contact is set and configured for the aws account by returning `true` if the api response is not null or data exists in the raw data.

```ruby
it { should be_configured }
```

## AWS Permissions

{{% aws_permissions_principal action="Aws::Account::Types::GetAlternateContactResponse" %}}
