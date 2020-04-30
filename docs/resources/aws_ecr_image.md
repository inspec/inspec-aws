---
title: About the aws_ecr_image Resource
---

# aws\_ecr\_image

Use the `aws_ecr_image` InSpec audit resource to test the properties of a single image in an AWS Elastic Container Registry (ECR) repository.
This resource is available in InSpec AWS resource pack version **[1.11.0](https://github.com/inspec/inspec-aws/releases/tag/v1.11.0)** onwards.

## Syntax

An `aws_ecr_image` resource block declares the tests for a single image in an AWS ECR repository by repository name and image identifier.

    describe aws_ecr_image(repository_name: 'my-repo', image_tag: 'latest') do
      it { should exist }
    end

#### Parameters

The repository name and the image identifier must be provided.

##### repository\_name _(required)_

The name of the ECR repository must satisfy the following constraints:
- Regex pattern `(?:[a-z0-9]+(?:[._-][a-z0-9]+)*/)*[a-z0-9]+(?:[._-][a-z0-9]+)*`.
- Minimum 2 and maximum of 256 characters long.

##### image\_tag _(required if `image_digest` not provided)_

The tag used for the image. It can not be longer than 300 characters.

##### image\_digest _(required if `image_tag` not provided)_

The `sha256` digest of the image manifest. It must satisfy this regex pattern: `[a-zA-Z0-9-_+.]+:[a-fA-F0-9]+`.


## Properties

|Property                     | Description |
| ---                         | --- |
|repository\_name             | The name of the repository.|
|registry\_id                 | The AWS account ID associated with the registry that contains the repository. |
|tags                         | The list of tags associated with this image. |
|vulnerability_severity_counts| The image vulnerability counts, sorted by severity, e.g. `{:high=>1}`.|
|vulnerabilities              | A list of hashes with each key-value pair corresponding to an image [scan findings](https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_ImageScanFinding.html). E.g. `{:name=>"CVE-2019-14697", :uri=>"https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-14697", :severity=>"HIGH", :package_version=>"1.1.18-r3", :package_name=>"musl", :CVSS2_VECTOR=>"AV:N/AC:L/Au:N/C:P/I:P/A:P", :CVSS2_SCORE=>"7.5"}`|


There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_ImageDetail.html)

## Examples

##### Test the scan status of an image

    describe aws_ecr_image(repository_name: 'my-repo', image_tag: 'latest') do
      its('image_scan_status.status') { should eq 'COMPLETE' }
    end
    
    
##### Test that an image has a certain tag

    describe aws_ecr_image(repository_name: 'my-repo', image_digest: 'sha256:687fba9b76554c8dea4c40fed4144011f29b8e1d5db5f2fc976c64ed31894967') do
      its('tags') { should include('latest') }
    end
    
## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

   
#### exist

    describe aws_ecr_image(repository_name: 'my-repo', image_tag: 'latest') do
        it { should exist }
    end
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ecr:DescribeImages` and `ecr:DescribeImageScanFindings` actions set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ECR](https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_Operations.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
