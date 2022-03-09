+++
title = "{{ .Name | humanize | title }} resource"
draft = false
gh_repo = "inspec"
platform = "aws"

[menu]
  [menu.inspec]
    title = "{{ .Name | humanize | title }}"
    identifier = "inspec/resources/aws/{{ .Name | humanize | title }}"
    parent = "inspec/resources/aws"
+++

{{% Run `hugo new -k resource inspec/resources/RESOURCE_NAME.md` to generate a new resource page. %}}

Use the `RESOURCE_NAME` Chef InSpec audit resource to test the configuration of...

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::RESOURCE::NAME` resource]().

## Installation

{{% inspec_aws_install %}}

## Syntax

```ruby
describe RESOURCE do
  #...
end
```

## Parameters

`PARAMETER`
: PARAMETER DESCRIPTION

`PARAMETER`
: PARAMETER DESCRIPTION

## Properties

`PROPERTY`
: PROPERTY DESCRIPTION

`PROPERTY`
: PROPERTY DESCRIPTION

## Examples

**EXAMPLE DESCRIPTION**

```ruby
describe RESOURCE do
  #...
end
```

**EXAMPLE DESCRIPTION**

```ruby
describe RESOURCE do
  #...
end
```

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

## AWS Permissions

{{% aws_permissions_principal action="ACTION" %}}
