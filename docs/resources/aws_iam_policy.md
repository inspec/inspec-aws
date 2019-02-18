---
title: About the aws_iam_policy Resource
platform: aws
---

# aws\_iam\_policy

Use the `aws_iam_policy` InSpec audit resource to test properties of a single managed AWS IAM Policy. Use `aws_iam_policies` to audit IAM policies in bulk.

A policy defines the permissions of an identity or resource within AWS. AWS evaluates these policies when a principal, such as a user, makes a request. Policy permissions, also called "policy statements" in AWS, determine if a request is authorized -- and allow or deny it accordingly.

Each IAM Policy is uniquely identified by either its policy\_name or arn.

<br>

## Syntax

An `aws_iam_policy` resource block identifies a policy by policy name or arn

    # Find a policy by name
    describe aws_iam_policy('AWSSupportAccess') do
      it { should exist }
    end

    # Find a customer-managed by name
    describe aws_iam_policy('customer-managed-policy') do
      it { should exist }
    end

    # Hash syntax for policy name
    describe aws_iam_policy(policy_name: 'AWSSupportAccess') do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Test that a policy does exist

    describe aws_iam_policy('AWSSupportAccess') do
      it { should exist }
    end

### Test that a policy is attached to at least one entity

    describe aws_iam_policy('AWSSupportAccess') do
      it { should be_attached }
    end

### Examine the policy statements

    describe aws_iam_policy('my-policy') do
      # Verify that there is at least one statement allowing access to S3
      it { should have_statement(Action: 's3:PutObject', Effect: 'allow') }

      # have_statement does not expand wildcards. If you want to verify
      # they are absent, an explicit check is required.
      it { should_not have_statement(Action: 's3:*') }
    end

<br>

## Properties

* `arn`
* `attachment_count`
* `attached_groups` 
* `attached_roles`
* `attached_users`
* `default_version_id`
* `policy`
* `statement_count`

## Property Examples

### arn

"The ARN identifier of the specified policy. An ARN uniquely identifies the policy within AWS."

    describe aws_iam_policy('AWSSupportAccess') do
      its('arn') { should cmp "arn:aws:iam::aws:policy/AWSSupportAccess" }
    end

### attachment\_count

The count of attached entities for the specified policy.

    describe aws_iam_policy('AWSSupportAccess') do
      its('attachment_count') { should cmp 1 }
    end

### attached\_groups

The list of groupnames of the groups attached to the policy.

    describe aws_iam_policy('AWSSupportAccess') do
      its('attached_groups') { should include "test-group" }
    end

### attached\_roles

The list of rolenames of the roles attached to the policy.

    describe aws_iam_policy('AWSSupportAccess') do
      its('attached_roles') { should include "test-role" }
    end

### attached\_users

The list of usernames of the users attached to the policy.

    describe aws_iam_policy('AWSSupportAccess') do
      its('attached_users') { should include "test-user" }
    end

### default\_version\_id

The 'default_version_id' value of the specified policy.

    describe aws_iam_policy('AWSSupportAccess') do
      its('default_version_id') { should cmp "v1" }
    end

### policy

This is a low-level, unsupported property.

Returns the default version of the policy document after decoding as a Ruby hash. This hash contains the policy statements and is useful for performing checks that cannot be expressed using higher-level matchers like `have_statement`.

For details regarding the contents of this structure, refer to the [AWS IAM Policy JSON Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies.html).  A set of examples is [also available](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_examples.html).

Example:

    # Fetch the policy structure as a Ruby object
    policy_struct = aws_iam_policy('my-policy').policy
    # Write a manually-constructed test to check that the policy
    # has an IP constraint on the first statement
    # ( Based on https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_deny-ip.html )
    describe 'Check that we are restricting IP access' do
      subject { policy_struct['Statement'].first['Condition'] }
      it { should include 'NotIpAddress' }
    end

### statement\_count

Returns the number of statements present in the `policy`.

    # Make sure there are exactly two statements.
    describe aws_iam_policy('my-policy') do
      its('statement_count') { should cmp 2 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### be\_attached

The test will pass if the identified policy is attached to at least one IAM user, group, or role.

    describe aws_iam_policy('AWSSupportAccess') do
      it { should be_attached }
    end

### be\_attached\_to\_group(GROUPNAME)

The test will pass if the identified policy attached the specified group.

    describe aws_iam_policy('AWSSupportAccess') do
      it { should be_attached_to_group(GROUPNAME) }
    end

### be\_attached\_to\_user(USERNAME)

The test will pass if the identified policy attached the specified user.

    describe aws_iam_policy('AWSSupportAccess') do
      it { should be_attached_to_user(USERNAME) }
    end

### be\_attached\_to\_role(ROLENAME)

The test will pass if the identified policy attached the specified role.

    describe aws_iam_policy('AWSSupportAccess') do
      it { should be_attached_to_role(ROLENAME) }
    end

### have\_statement

Examines the list of statements contained in the policy and passes if at least one of the statements matches. This matcher does _not_ interpret the policy in a request authorization context, as AWS does when a request processed. Rather, `have_statement` examines the literal contents of the IAM policy, and reports on what is present (or absent, when used with `should_not`).

`have_statement` accepts the following criteria to search for matching statements. If any statement matches all the criteria, the test is successful.  All criteria may be used as Titlecase (as in the AWS examples) or lowercase, string or symbol.

* `Action` - Expresses the requested operation. Acceptable literal values are any AWS operation name, including the '*' wildcard character. `Action` may also use a list of AWS operation names.
* `Effect` - Expresses if the operation is permitted. Acceptable values are 'Deny' and 'Allow'.
* `Sid` - A user-provided string identifier for the statement.
* `Resource` - Expresses the operation's target. Acceptable values are ARNs, including the '*' wildcard. `Resource` may also use a list of ARN values.

Please note the following about the behavior of `have_statement`:
* `Action`, `Sid`, and `Resource` allow using a regular expression as the search critera instead of a string literal.
* it does not support wildcard expansion; to check for a wildcard value, check for it explicitly. For example, if the policy includes a statement with `"Action": "s3:*"` and the test checks for `Action: "s3:PutObject"`, the test _will not match_. You must write an additional test checking for the wildcard case.
* it supports searching list values. For example, if a statement contains a list of 3 resources, and a `have_statement` test specifes _one_ of those resources, it will match.
* `Action` and `Resource` allow using a list of string literals or regular expressions in a test, in which case _all_ must match on the _same_ statement for the test to match. Order is ignored.
* it does not support the `[Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal)` or `Conditional` key, or any of `NotAction`, `Not[Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal)`, or `NotResource`.

Examples:

    # Verify there is no full-admin statement
    describe aws_iam_policy('kryptonite') do
      it { should_not have_statement('Effect' => 'Allow', 'Resource' => '*', 'Action' => '*')}
    end

    # Symbols and lowercase also allowed as criteria
    describe aws_iam_policy('kryptonite') do
      # All 4 the same
      it { should_not have_statement('Effect' => 'Allow', 'Resource' => '*', 'Action' => '*')}
      it { should_not have_statement('effect' => 'Allow', 'resource' => '*', 'action' => '*')}
      it { should_not have_statement(Effect: 'Allow', Resource: '*', Action: '*')}
      it { should_not have_statement(effect: 'Allow', resource: '*', action: '*')}
    end

    # Verify bob is allowed to manage things on S3 buckets that start with bobs-stuff
    describe aws_iam_policy('bob-is-a-packrat') do
      it { should have_statement(Effect: 'Allow',
                                 # Using the AWS wildcard - this must match exactly
                                 Resource: 'arn:aws:s3:::bobs-stuff*',
                                 # Specify a list of actions - all must match, no others, order isn't important
                                 Action: ['s3:PutObject', 's3:GetObject', 's3:DeleteObject'])}

      # Bob would make new buckets constantly if we let him.
      it { should_not have_statement(Effect: 'Allow', Action: 's3:CreateBucket')}
      it { should_not have_statement(Effect: 'Allow', Action: 's3:*')}
      it { should_not have_statement(Effect: 'Allow', Action: '*')}

      # An alternative to checking for wildcards is to specify the
      # statements you expect, then restrict statement count
      its('statement_count') { should cmp 1 }
    end

    # Use regular expressions to examine the policy
    describe aws_iam_policy('regex-demo') do
      # Check to see if anything mentions RDS at all.
      # This catches `rds:CreateDBinstance` and `rds:*`, but would not catch '*'.
      it { should_not have_statement(Action: /^rds:.+$/)}

      # This policy should refer to both sally and kim's s3 buckets.
      # This will only match if there is a statement that refers to both resources.
      it { should have_statement(Resource: [/arn:aws:s3.+:sally/, /arn:aws:s3.+:kim/]) }
      # The following also matches on a statement mentioning only one of them
      it { should have_statement(Resource: /arn:aws:s3.+:(sally|kim)/) }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `iam:GetPolicy`, `iam:ListPolicy`, and `iam:ListEntitiesForPolicy` actions set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
aws_iam_policy.md