require_relative 'aws_base_resource_mock'

class AwsEcrMock < AwsBaseResourceMock

  def initialize
    super
    @ecr = {repositories: [{registry_id: @aws.any_string,
                            repository_arn: @aws.any_arn,
                            repository_name: @aws.any_string,
                            created_at: Time.now,
                            repository_uri: @aws.any_string }]}
  end

  def stub_data
    stub_data = []

    ecr = {:client => Aws::ECR::Client,
              :method => :describe_repositories,
              :data => @ecr}

    stub_data += [ecr]
  end

  def ecr
    @ecr
  end
end