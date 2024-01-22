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

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

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

Example description.

```ruby
describe {{ .Name }} do
  #...
end
```

Example description.

```ruby
describe {{ .Name }} do
  #...
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### <MATCHER_NAME>

Matcher description.

```ruby
describe {{ .Name }} do
  # matcher example
end
```

## AWS Permissions

{{% aws_permissions_principal action="ACTION" %}}
