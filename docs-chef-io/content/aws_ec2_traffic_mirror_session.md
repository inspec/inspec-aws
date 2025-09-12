+++
title = "aws_ec2_traffic_mirror_session resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_traffic_mirror_session"
identifier = "inspec/resources/aws/aws_ec2_traffic_mirror_session resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_traffic_mirror_session` InSpec audit resource to test properties an AWS Traffic Mirror session.

## Syntax

An `aws_ec2_traffic_mirror_session` resource block declares the tests for a single AWS Traffic Mirror session by session ID.

```ruby
describe aws_ec2_traffic_mirror_session(traffic_mirror_session_id: 'TRAFFIC_MIRROR_SESSION_ID') do
  it { should exist }
end
```

## Parameters

`traffic_mirror_session_id` _(required)_

: The ID of the Traffic Mirror session.

## Properties

`traffic_mirror_session_id`
: The ID for the Traffic Mirror session.

`traffic_mirror_target_id`
: The ID of the Traffic Mirror target.

`traffic_mirror_filter_id`
: The ID of the Traffic Mirror filter.

`network_interface_id`
: The ID of the Traffic Mirror session's network interface.

`owner_id`
: The ID of the account that owns the Traffic Mirror session.

`packet_length`
: The number of bytes in each packet to mirror.

`virtual_network_id`
: The virtual network ID associated with the Traffic Mirror session.

`description`
: The description of the Traffic Mirror session.

`tags`
: The tags assigned to the Traffic Mirror session.

`session_number`
: The session number determines the order in which sessions are evaluated when an interface is used by multiple sessions.

For additional information, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_TrafficMirrorSession.html).

## Examples

**Test that a Traffic Mirror session should exist.**

```ruby
describe aws_ec2_traffic_mirror_session(traffic_mirror_session_id: 'TRAFFIC_MIRROR_SESSION_ID') do
  it { should exist }
end
```

**Test the packet length of a Traffic Mirror session.**

```ruby
describe aws_ec2_traffic_mirror_session(traffic_mirror_session_id: 'TRAFFIC_MIRROR_SESSION_ID') do
  its('packet_length') { should eq 1 }
end
```

**Test that a Traffic Mirror session has the correct ID.**

```ruby
describe aws_ec2_traffic_mirror_session(traffic_mirror_session_id: 'TRAFFIC_MIRROR_SESSION_ID') do
  its('traffic_mirror_session_id') { should eq 'TRAFFIC_MIRROR_SESSION_ID' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_available

Check if the Traffic Mirror session is available.

```ruby
describe aws_ec2_traffic_mirror_session(traffic_mirror_session_id: 'TRAFFIC_MIRROR_SESSION_ID') do
  it { should be_available }
end
```

Use `should_not` to test a Traffic Mirror session that should not exist.

```ruby
describe aws_ec2_traffic_mirror_session(traffic_mirror_session_id: 'TRAFFIC_MIRROR_SESSION_ID') do
  it { should_not be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeTrafficMirrorSessionsResult" %}}
