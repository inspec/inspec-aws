---
title: About the aws_cloudfront_distribution Resource
platform: aws
---

# aws\_cloudfront\_distribution

Use the `aws_cloudfront_distribution` InSpec audit resource to test properties of a single AWS CloudFront Distribution.

## Syntax

Ensure that an `aws_cloudfront_distribution` exists:

    describe aws_cloudfront_distribution('DISTRIBUTION') do
      it { should exist }
    end

    describe aws_cloudfront_distribution(distribution_id: 'DISTRIBUTION') do
      it { should exist }
    end

#### Parameters

##### distribution\_id _(required)_

The ID of the CloudFront Distribution. This can be passed either as a string or as a `name: 'value'` key-value entry in a hash.

##### disallowed\_ssl\_protocols _(optional)_

If provided, this parameter is expected to be an array of strings identifying SSL/TLS protocols that you wish not to allow.

Included in the array should be the union of disallowed identifiers for:
- custom origin SSL/TLS protocols (currently SSLv3 | TLSv1 | TLSv1.1 | TLSv1.2)
- identifiers for the minimum SSL/TLS protocol in the Viewer Certificate that CloudFront can use to communicate with viewers (currently SSLv3 | TLSv1 | TLSv1_1026 | TLSv1.1_2016 | TLSv1.2_2018 | TLSv1.2_2019 | TLSv1.2_2021).

Newer protocol identification strings (when available) may be provided in the set, as validity is not checked. The default value for disallowed_ssl_protocols is `%w{SSLv3 TLSv1 TLSv1_2016}`.

See also the [AWS API reference for CloudFront Distributions](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_Distribution.html). For available SSL/TLS version identifiers, see [OriginSslProtocols](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_OriginSslProtocols.html) and [AWS::CloudFront::Distribution ViewerCertificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cloudfront-distribution-viewercertificate.html).

## Properties

|Property                       	     | Description|
| ---                                        | --- |
|distribution\_id                            | The identifier for the CloudFront distribution. |
|viewer\_protocol\_policies                  | An array of viewer protocol policies for all caches in this distribution; valid policy names are 'allow-all' (which allows http and https), 'https-only' or 'redirect-to-https'. |
|custom\_origin\_ssl\_protocols              | An array containing SSL/TLS protocols allowed by custom origins in this distribution, empty if there are no no custom origins (i.e. only one or more standard S3 bucket origins). Current valid values: "SSLv3", "TLSv1", "TLSv1.1", "TLSv1.2". |
|viewer\_certificate\_minimum\_ssl\_protocol | The minimum SSL/TLS protocol version in the Viewer Certificate. Current valid values: "SSLv3", "TLSv1", "TLSv1\_2016", "TLSv1.1\_2016", "TLSv1.2\_2018", "TLSv1.2\_2019", "TLSv1.2\_2021". |
|s3\_origin\_config                          | True if there are any S3 origin configs in the distribution (i.e. standard S3 bucket origins), false otherwise. |

## Examples

##### Test that a CloudFront Distribution has secure protocols configured
    describe aws_cloudfront_distribution('CLOUD99') do
      its('viewer_certificate_minimum_ssl_protocol') { should_not match /SSLv3|TLSv1$|TLSv1_2016/ }
      its('viewer_protocol_policies') { should_not include 'allow-all' }
      %w{SSLv3 TLSv1}.each do |protocol|
        its('custom_origin_ssl_protocols') { should_not include protocol }
      end
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### have_viewer_protocol_policies_allowing_http

The `have_viewer_protocol_policies_allowing_http` matcher tests if any of the caches for origins, including the default cache, has its viewer_protocol_policy set to 'allow-all'.

    it { should_not have_viewer_protocol_policies_allowing_http }

#### have\_disallowed\_custom\_origin\_ssl\_protocols

The `have_disallowed_custom_origin_ssl_protocols` matcher tests whether any of the the SSL/TLS protocols
defined in the ssl_protocols for all custom origins in the distribution are present in the
`disallowed_ssl_protocols` parameter (if provided), or in the default disallowed SSL/TLS protocol list (if not).

    it { should_not have_disallowed_custom_origin_ssl_protocols }

#### have\_disallowed\_viewer\_certificate\_minimum\_ssl\_protocol

The `have_disallowed_viewer_minimum_ssl_protocol` matcher tests whether the minimum SSL/TLS protocol
for the distribution's Viewer Certificate is in the `disallowed_ssl_protocols` parameter (if provided),
or in the default disallowed SSL/TLS protocol list (if not).

    it { should_not have_disallowed_viewer_certificate_minimum_ssl_protocol }

#### have\_s3\_origin\_configs

The `have_s3_origin_configs` matcher tests whether the distribution has a non-nil s3_origin_configs setting in
any of its origins.

    it { should_not have_s3_origin_configs }

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_cloudfront_distribution('EXISTING') do
      it { should exist }
    end

    describe cloudfront_distribution('NONEXISTING') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `cloudfront:GetDistribution` action set to Allow.

You can find detailed documentation at [Identity and Access Management (IAM) in CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/auth-and-access-control.html).
