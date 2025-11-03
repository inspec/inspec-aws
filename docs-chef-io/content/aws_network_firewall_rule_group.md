+++
title = "aws_network_firewall_rule_group resource"

draft = false


[menu.aws]
title = "aws_network_firewall_rule_group"
identifier = "inspec/resources/aws/aws_network_firewall_rule_group resource"
parent = "inspec/resources/aws"
+++

Use the `aws_network_firewall_rule_group` InSpec audit resource to test properties of a single specific AWS Network Firewall rule group.

The `AWS::NetworkFirewall::RuleGroup` resource defines a reusable collection of stateless or stateful network traffic filtering rules.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Network Firewall Rule Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-rulegroup.html).

## Syntax

Ensure that the firewall exists.

```ruby
describe aws_network_firewall_rule_group(rule_group_name: "RULE_GROUP_NAME") do
  it { should exist }
end
```

## Parameters

`rule_group_name` _(required)_

: The descriptive name of the rule group.

## Properties

`update_token`
: A token used for optimistic locking.

`rule_group.rule_variables.ip_sets`
: A list of IP addresses and address ranges, in CIDR notation.

`rule_group.rule_variables.ip_sets["RuleVariableName"].definition`
: The list of IP addresses and address ranges, in CIDR notation.

`rule_group.rule_variables.port_sets`
: A list of port ranges.

`rule_group.rule_variables.port_sets["RuleVariableName"].definition`
: The set of port ranges.

`rule_group.rules_source.rules_string`
: Stateful inspection criteria, provided in Suricata compatible intrusion prevention system (IPS) rules.

`rule_group.rules_source.rules_source_list.targets`
: The domains that you want to inspect for in your traffic flows.

`rule_group.rules_source.rules_source_list.target_types`
: The protocols you want to inspect. Specify TLS_SNI for HTTPS.

`rule_group.rules_source.rules_source_list.generated_rules_type`
: Whether you want to allow or deny access to the domains in your target list.

`rule_group.rules_source.stateful_rules`
: The 5-tuple stateful inspection criteria.

`rule_group.rules_source.stateful_rules.first.action`
: Defines what Network Firewall should do with the packets in a traffic flow when the flow matches the stateful rule criteria.

`rule_group.rules_source.stateful_rules.first.header.protocol`
: The protocol to inspect for.

`rule_group.rules_source.stateful_rules.first.header.source`
: The source IP address or address range to inspect for, in CIDR notation.

`rule_group.rules_source.stateful_rules.first.header.source_port`
: The source port to inspect for.

`rule_group.rules_source.stateful_rules.first.header.direction`
: The direction of traffic flow to inspect.

`rule_group.rules_source.stateful_rules.first.header.destination`
: The destination IP address or address range to inspect for, in CIDR notation.

`rule_group.rules_source.stateful_rules.first.header.destination_port`
: The destination port to inspect for.

`rule_group.rules_source.stateful_rules.first.rule_options`
: Additional settings for a stateful rule.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules`
: Defines the set of stateless rules for use in a stateless rule group.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.match_attributes.sources`
: The source IP addresses and address ranges to inspect for.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.match_attributes.sources.first.address_definition`
: Specify an IP address or a block of IP addresses in Classless Inter-Domain Routing (CIDR) notation.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.match_attributes.destinations`
: The destination IP addresses and address ranges to inspect for, in CIDR notation.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.match_attributes.destinations.first.address_definition`
: Specify an IP address or a block of IP addresses in Classless Inter-Domain Routing (CIDR) notation.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.match_attributes.source_ports`
: The source ports to inspect for.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.match_attributes.source_ports.first.from_port`
: The lower limit of the port range.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.match_attributes.source_ports.first.to_port`
: The upper limit of the port range.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.match_attributes.destination_ports`
: The destination ports to inspect for.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.match_attributes.destination_ports.first.from_port`
: The lower limit of the port range.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.match_attributes.destination_ports.first.to_port`
: The upper limit of the port range.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.match_attributes.protocols`
: The protocols to inspect for, specified using each protocol's assigned internet protocol number (IANA).

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.match_attributes.tcp_flags`
: The TCP flags and masks to inspect for.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.match_attributes.tcp_flags.first.flags`
: Used in conjunction with the Masks setting to define the flags that must be set and flags that must not be set in order for the packet to match.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.match_attributes.tcp_flags.first.masks`
: The set of flags to consider in the inspection.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.rule_definition.actions`
: The actions to take on a packet that matches one of the stateless rule definition's match attributes.

`rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rules.first.priority`
: A setting that indicates the order in which to run this rule relative to all of the rules that are defined for a stateless rule group.

`rule_group.rules_source.stateless_rules_and_custom_actions.custom_actions`
: Defines an array of individual custom action definitions that are available for use by the stateless rules in this StatelessRulesAndCustomActions specification.

`rule_group.rules_source.stateless_rules_and_custom_actions.custom_actions.first.action_name`
: The descriptive name of the custom action.

`rule_group.rules_source.stateless_rules_and_custom_actions.custom_actions.first.action_definition.publish_metric_action.dimensions`
: The value to use in an Amazon CloudWatch custom metric dimension.

`rule_group.rules_source.stateless_rules_and_custom_actions.custom_actions.first.action_definition.publish_metric_action.dimensions.first.value`
: The value to use in the custom metric dimension.

`rule_group_response.rule_group_arn`
: The Amazon Resource Name (ARN) of the rule group.

`rule_group_response.rule_group_name`
: The descriptive name of the rule group.

`rule_group_response.rule_group_id`
: The unique identifier for the rule group.

`rule_group_response.description`
: A description of the rule group.

`rule_group_response.type`
: Indicates whether the rule group is stateless or stateful.

`rule_group_response.capacity`
: The maximum operating resources that this rule group can use.

`rule_group_response.rule_group_status`
: Detailed information about the current status of a rule group.

`rule_group_response.tags`
: The key:value pairs to associate with the resource.

## Examples

Ensure an update token is available:

```ruby
describe aws_network_firewall_rule_group(rule_group_name: "RULE_GROUP_NAME") do
  its('update_token') { should eq 'UPDATE_TOKEN' }
end
```

Ensure that the rule group arn is `RuleGroupARN`:

```ruby
describe aws_network_firewall_rule_group(rule_group_name: "RULE_GROUP_NAME") do
    its('rule_group_response.rule_group_arn') { should eq 'ARN' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_network_firewall_rule_group(rule_group_name: "RULE_GROUP_NAME") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_network_firewall_rule_group(rule_group_name: 'dummy') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_network_firewall_rule_group(rule_group_name: "RULE_GROUP_NAME") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="NetworkFirewall:Client:DescribeRuleGroupResponse" %}}
