# inspec-aws 

This is incubation for the new InSpec AWS standalone resource pack.  Below is not intended as an end-user README, it contains notes and discussion points for the implementation. 

## Enviroment Setup Notes

### Train and InSpec Dependencies

In order to use the latest SDK the `aws-sdk` version in train must be updated to avoid conflicts e.g.

```
Bundler could not find compatible versions for gem "aws-sdk":
  In Gemfile:
    aws-sdk (~> 3)

    inspec (>= 3.0.25, ~> 3.0) was resolved to 3.0.52, which depends on
      train (>= 1.5.6, ~> 1.5) was resolved to 1.5.6, which depends on
        aws-sdk (~> 2)
```

For this initial prototype, an explicit dependency on train and inspec is required in the Gemfile.  To make this simpler, add the equivalent of the following to your envrc:

```
export INSPEC_AWS_TRAIN_PATH='/Users/spaterson/Documents/workspace/aws/train'
export INSPEC_AWS_INSPEC_PATH='/Users/spaterson/Documents/workspace/aws/inspec
```

The local InSpec version has all AWS components removed.  The local train version is upgraded to SDK version 3 to avoid the above conflict.  

## Discussion Points

### Train and InSpec Update Options

At the time of writing the proposal would be to do the following:
1. Update train AWS transport to SDK3 (TBD whether or not to upgrade existing AWS components in InSpec initially)
2. Remove AWS components from InSpec, use classes within `inspec-aws` as a replacement
3. TBD - instead of relying on train, use connection logic within the resource pack for AWS client instantiation.

The thinking behind 3. is to decouples the resource pack from the train release cycle.  This also simplifies testing and makes it easier to supply additional options at client instantiation e.g. for switching endpoints.

## Resource Unit tests

Neither `inspec-gcp` or `inspec-azure` have resource unit tests and have instead opted for integration tests only.  However, unit tests can be useful for parameter validation and exception checking/handling.  For example:

```
describe aws_vpc( vpc_id: 'vpc-not-formatted-correctly-123') do
   it { should_not exist }
end
```

By design the original implementation of the above throws a source code error (ArgumentError) but this cannot be easily triggered as part of integration tests. 

Therefore, pursuing minimal unit tests for the gaps not covered by integration seems prudent as a starting point.  Simple stubbing can be achieved via the AWS SDK e.g.
[https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/stubbing.html]
This will allow more rapid development of new resources.

##  Plural singular resource woes 

VPCs have a function to describe 'all'.  This fine but we have to artificially restrict results for singular resources.  The plural resource could cache everything from one API interaction as an improvement.  Same thing often happens in GCP / AWS.

For background, I was trying to expose filtering by tags for the singular resource.  When only one VPC applies this isn't an issue, however, should several apply, we end up in a mess.
```
    filter = opts[:filter] if opts[:filter]
    
    # can't offer the filter for singular resource here in case >1 results are returned
    
    describe aws_vpc( filter: { name: 'tag:Name', values: [aws_vpc_name] } ) do
    ...
```

## Accepting scalar arguments

Originally it was possible to supply single string args as a default.  For example:

```
describe aws_vpc('vpc-id') do
# instead of forcing the more explicit
describe aws_vpc( vpc_id: 'vpc-id') do
```

This is supported for simplicity but perhaps it would be worth removing the option altogether? 