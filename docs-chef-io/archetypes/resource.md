+++
title = "{{ .Name }} resource"
draft = false
gh_repo = "inspec"
platform = "aws"

[menu]
  [menu.inspec]
    title = "{{ .Name }}"
    identifier = "inspec/resources/aws/{{ .Name | humanize | title }}"
    parent = "inspec/resources/aws"
+++
{{/* Run `hugo new -k resource inspec/resources/RESOURCE_NAME.md` to generate a new resource page. */}}

Use the `{{ .Name }}` Chef InSpec audit resource to test the configuration of...

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::RESOURCE::NAME` resource]().

## Installation

{{% inspec_aws_install %}}

## Syntax

```ruby
describe {{ .Name }} do
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
describe {{ .Name }} do
  #...
end
```

**EXAMPLE DESCRIPTION**

```ruby
describe {{ .Name }} do
  #...
end
```

## Matchers

{{% inspec_matchers_link %}}

## AWS Permissions

{{% aws_permissions_principal action="ACTION" %}}
