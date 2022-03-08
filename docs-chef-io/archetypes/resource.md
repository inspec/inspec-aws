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

## Installation

{{% inspec_aws_install %}}

## Syntax

## Parameters

## Properties

## Examples

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

## AWS Permissions

{{% aws_permissions_principal action="ACTION" %}}
