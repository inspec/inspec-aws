+++
title = "aws_regions Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_regions"
identifier = "inspec/resources/aws/aws_regions Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_regions` InSpec audit resource to test properties of some or all AWS regions in bulk.  

Note that this resource lists all AWS regions that are currently available to the caller.

For additional information, including details on parameters and properties, see the [AWS documentation on Regions](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_regions` resource block uses an optional filter to select a group of regions and then tests that group.

```ruby
describe aws_regions.where { region_name: 'us-not-there-1' } do
  it { should_not exist }
end
```

## Parameters

`name` _(required)_

: This resource does not expect any parameters.

## Properties

`region_names`
: The Names of the regions.

`endpoints`
: The resolved endpoints of the regions.

## Examples

The following examples show how to use this InSpec audit resource.

**Check for a Particular Region.**

```ruby
describe aws_regions do
  its('region_names') { should include 'eu-west-2' }
end
```


**Check an endpoint exists.**

```ruby
describe aws_regions do
  its('endpoints') { should include 'ec2.eu-west-2.amazonaws.com' }
end
```

**Use the regions resource to check single regions in more detail.**

```ruby
aws_regions.region_names.each do |aws_region_name|
  describe aws_region(region_name: aws_region_name) do
    it { should exist }
  end
end
```

## Matchers

For a full list of available matchers, visit the [InSpec matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

```ruby
it { should exist }
```



## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeRegionsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
