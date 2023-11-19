+++
title = "aws_alternate_contact Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_alternate_contact"
identifier = "inspec/resources/aws/aws_alternate_contact Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_alternate_contact` InSpec audit resource to test properties of the alternate contact information associated with your account.

For additional information, including details on parameters and properties, see the [AWS documentation on the alternate contact information associated with your account](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-update-contact-alternate.html). Technical details on the data structure can be found for the [api documentation.](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Account/Client.html#get_contact_information-instance_method)

## Installation

{{% inspec_aws_install %}}

## Syntax

The `aws_alternate_contact` resource allows the testing of the alternate contact information associated with your account.

```ruby
describe aws_alternate_contact do
  it { should exist }
end
```

## Parameters

`type` _(required)_

: This resource accepts a single parameter, the type of the alternate contact type.
  This can be passed either as a string or as a `type: 'value'` key-value entry in a hash. Valid types are 'billing', 'operations' and 'security'

## Properties


`api_response` (Struct) 
: Returns the api response from our call to the aws api as a struct.

`raw_data` (Hash)
: Returns a transformed Hash of Strings of the data associated with the alternate contact.

`aws_account_id` (String)
: 12-digit account ID number of the Amazon Web Services account associated with the alternate contact.

`name` (String)
: Specifies the full name of the alternate contact.

`title` (String)
: Specifies the full name of the alternate contact.

`email_address` (String)
: Specifies the full name of the alternate contact.

`phone_number` (String)
: Specifies the phone number associated with the alternate contact.

## Examples

The following examples show how to use this InSpec audit resource.

**Test that a alternate contact exists for the aws account.**

```ruby
describe aws_alternate_contact do
  it { should exist }
end
```

**Test that the alternate contact is set and the values for its full name and first address line are set as expected.**

```ruby
describe aws_alternate_contact(type: 'billing') do
  it { should be_configured }
  its('name') { should cmp 'John Smith' }
  its('title') { should cmp 'Money Guy' }
end
```
```ruby
describe aws_alternate_contact('security') do
  it { should exist }
  its('name') { should cmp 'Jane Smith' }
  its('title') { should cmp 'Security Gal' }
end
```

## Matchers

{{% inspec_matchers_link %}}

### exist (alias of configured)

Use `should` to test if the aws account has a alternate contact configured.

```ruby
it { should exist }
```

### configured

The `configured` matcher tests if the described alternate contact is set and configured for the aws account by returning `true` if the api response is not null or data exists in the raw data.

```ruby
it { should be_configured }
```

## AWS Permissions

{{% aws_permissions_principal action="Aws::Account::Types::GetAlternateContactResponse" %}}
