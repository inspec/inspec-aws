---
title: About the aws_cloudfront_distributions Resource
platform: aws
---

# aws\_cloudfront\_distributions

Use the `aws_cloudfront_distributions` InSpec audit resource to test properties of a collection of AWS CloudFront distributions.

## Syntax

Ensure that a particular CloudFront distribution exists in `aws_cloudfront_distributions`:

    describe aws_cloudfront_distributions do
      its('distribution_ids') { should include 'DISTRIBUTION_ID' }
    end

## Parameters

This resource does not expect any parameters.

See also the [AWS API reference for CloudFront distributions](https://docs.aws.amazon.com/cloudfront/latest/APIReference/API_distribution.html).

## Properties

|Property                                     | Description|
| ---                                         | --- |
|distribution_ids                            | The names of the CloudFront distributions. |
|distribution_arns                           | The Amazon Resource Name (ARN) of the CloudFront distributions. |
|statuses                                     | The statuses of the CloudFront distributions (`InProgress` or `Deployed`). |
|domain_names                                | The domain names for the CloudFront distributions. |
|origin_domains_names                       | The domain names for the CloudFront distributions' origins (an array for each distribution). |
|default_cache_viewer_protocol_policies   | The viewer protocol policy for the default cache for each of the CloudFront distributions. Values: `http-only`, `redirect-to-https` or `allow-all`. |
|cache_viewer_protocol_policies            | The viewer protocol policy for all non-default caches for each of the CloudFront distributions (an array for each distribution). Values: `http-only`, `redirect-to-https` or `allow-all`. There may be an empty array for a distribution if no non-default caches are present.|
|custom_origin_ssl_protocols               | An array for each CloudFront distribution containing SSL/TLS protocols allowed by all of the custom origins in that distribution, empty where no custom origins exist for a distribution. Current SSL/TLS protocol identifiers: `SSLv3`, `TLSv1`, `TLSv1_1026`, `TLSv1.1_2016`, `TLSv1.2_2018`, `TLSv1.2_2019` and `TLSv1.2_2021`. |
|s3_origin_config                           | Booleans indicating whether there are any S3 origin configs in a particular distribution (non-custom S3 bucket origins). |
|price_classes                               | The price classes for distributions, which corresponds with the maximum price that you want to pay for CloudFront service. Valid Values: `PriceClass_100`,  `PriceClass_200`,  `PriceClass_All`. |
|enabled                                      | Booleans indicating whether the distributions are enabled. |
|viewer_certificate_ssl_support_methods   | The SSL support methods for Viewer Certificates for the distributions, only set for distributions with aliases. Valid values: `sni-only`, `vip` or `static-ip`. |
|viewer_certificate_minimum_ssl_protocols | The minimum SSL/TLS protocol allowed by the Viewer Certificate in each distribution. Current valid values: `SSLv3`, `TLSv1`, `TLSv1_2016`, `TLSv1.1_2016`, `TLSv1.2_2018`, `TLSv1.2_2019`, `TLSv1.2_2021`. |
|http_versions                               | The maximum HTTP versions that viewers may to use to communicate with CloudFront distributions. Valid values: `http1.1` or `http2`. |
|ipv6_enabled                                | Booleans indicating whether IPv6 is enabled for CloudFront distributions. |

## Examples

### Test that a particular CloudFront distribution exists, and that no cache viewer protocol policies allow HTTP

    describe aws_cloudfront_distributions do
      its('distribution_ids') { should include 'DISTRIBUTION_ID' }
      its('default_cache_viewer_protocol_policies') { should_not include 'allow-all' }
      its('cache_viewer_protocol_policies') { should_not include 'allow-all' }
    end

## Matchers

This InSpec audit resource has no special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_cloudfront_distributions do
      it { should exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `cloudfront:Listdistributions` action set to Allow.

You can find detailed documentation at [Identity and Access Management (IAM) in CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/auth-and-access-control.html).
