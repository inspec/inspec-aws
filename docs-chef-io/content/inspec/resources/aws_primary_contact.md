+++
title = "aws_primary_contact Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_primary_contact"
identifier = "inspec/resources/aws/aws_primary_contact Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_primary_contact` InSpec audit resource to test properties of the primary contact information associated with your account.

For additional information, including details on parameters and properties, see the [AWS documentation on primary contact information associated with your account](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-update-contact-primary.html). Technical details on the data structure can be found for the [api documentation.](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Account/Client.html#get_contact_information-instance_method)

## Installation

{{% inspec_aws_install %}}

## Syntax

An `aws_primary_contact` resource allows the testing of the primary contact information associated with your account.

```ruby
describe aws_primary_contact do
  it { should exist }
end
```

## Parameters

This resources does not take any parameters at this time.

## Properties

`aws_account_id` (String)
: 12-digit account ID number of the Amazon Web Services account.

`address_line_1` (String)
: Specifies the first address line for the primary contact's address.

`address_line_2`  (String)
: Specifies the second address line for the primary contact's address.

`address_line_3` (String)
: Specifies the third address line for the primary contact's address.

`city` (String)
: Specifies the city for the primary contact's address.

`state_or_region` (String)
: Specifies the state or region for the primary contact's address.

`postal_code` (String)
: Specifies the postal code for the primary contact's address.

`country_code` (String)
: Specifies the country code of the primary contact.

`company_name` (String)
: Specifies the company name associated with the primary contact.

`full_name` (String)
: Specifies the full name of the primary contact.

`phone_number` (String)
: Specifies the phone number associated with the primary contact.

`website_url` (String)
: Specifies the website url associated with the primary contact.

`district_or_county` (String)
: Specifies the district or county associated with the primary contact.

`api_response` (Struct) 
: Returns the api response from our call to the aws api as a struct.

`raw_data` (Hash)
: Returns a transformed Hash of Strings of the data associated with the primary contact. 

## Examples

The following examples show how to use this InSpec audit resource.

**Test that a primary contact exists for the aws account.**

```ruby
describe aws_primary_contact do
  it { should exist }
end
```

**Test that an the primary contact is set and the values for its full name and first address line are set as expected.**

```ruby
describe aws_primary_contact do
  it { should be_configured }
  its('full_name') { should cmp 'John Smith' }
  its('address_line_1') { should cmp '42 Wallaby Way' }
end
```

## Matchers

{{% inspec_matchers_link %}}

### exist (alias of configured)

Use `should` to test the if the aws account has a primary contact configured.

```ruby
it { should exist }
```

### configured

The `configured` matcher tests if the primary contact is set and configured for the aws account by returning `true` if the api response is not null or data exists in the raw data.

```ruby
it { should be_configured }
```

## AWS Permissions

{{% aws_permissions_principal action="Aws::Account::Types::GetContactInformationResponse" %}}