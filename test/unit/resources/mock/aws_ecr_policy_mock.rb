require_relative 'aws_base_resource_mock'

class AwsEcrPolicyMock < AwsBaseResourceMock
  def initialize
    super
    @policy_required = {}
    @policy_required[:repository_name] = @aws.any_arn

    @policy = Hash[@policy_required]
    @policy[:repository_name] =  "testrepopolicy"  # string
    @policy[:policy_text] = '{
      "policyText": "{\n  \"Version\" : \"2012-10-17\",\n  \"Statement\" : [{\n    \"Sid\" : \"AllowPull\",\n    \"Effect\" : \"Allow\",\n    \"Principal\" : \"*\",\n    \"Action\" : [ \"ecr:BatchGetImage\", \"ecr:GetDownloadUrlForLayer\" ]\n  }\n ]\n}",
      "registryId": "012345678910",
      "repositoryName": "testrepopolicy"
    }'
  end

  def stub_data
    stub_data = []

    policy = { :client => Aws::ECR::Client,
               :method => :get_repository_policy,
               :data => { :policy_text =>  @policy[:policy_text],
                :repository_name  =>  @policy[:repository_name]}}

    
    stub_data += [policy]

  end

  def policy
    @policy
  end
end
