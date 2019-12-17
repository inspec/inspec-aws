require_relative '../aws_base_resource_mock'

class AwsIamPolicyMock < AwsBaseResourceMock
  def initialize
    super
    @policy_required = {}
    @policy_required[:arn] = @aws.any_arn
    @policy_required[:attachment_count] = @aws.any_int(10)
    @policy_required[:default_version_id] = "v#{@aws.any_int(10)}"
    @policy_required[:policy_name] = @aws.any_string
    @policy_required[:policy_id] = @aws.any_id

    @policy_version = {}
    @policy_version[:document] = "%7B%0A%20%20%22Version%22%3A%20%222012-10-17%22%2C%0A%20%20%22Statement%22%3A%20%5B%0A%20%20%20%20%7B%0A%20%20%20%20%20%20%22Action%22%3A%20%5B%0A%20%20%20%20%20%20%20%20%22ec2%3ADescribe%2A%22%0A%20%20%20%20%20%20%5D%2C%0A%20%20%20%20%20%20%22Effect%22%3A%20%22Allow%22%2C%0A%20%20%20%20%20%20%22Resource%22%3A%20%22%2A%22%0A%20%20%20%20%7D%2C%0A%20%20%20%20%7B%0A%20%20%20%20%20%20%22NotAction%22%3A%20%22s3%3ADeleteBucket%22%2C%0A%20%20%20%20%20%20%22Effect%22%3A%20%22Allow%22%2C%0A%20%20%20%20%20%20%22Resource%22%3A%20%22arn%3Aaws%3As3%3A%3A%3A%2A%22%0A%20%20%20%20%7D%0A%20%20%5D%0A%7D%0A"
    @policy_version[:version_id] = "v5"
    @policy_version[:is_default_version] = true

    @policy_document = Hash[@policy_version]

    @policy = Hash[@policy_required]
    @policy[:attached_groups] = []
    @policy[:attached_roles] = [{:role_name=>"test-role"}]
    @policy[:attached_users] = [{:user_name=>"test-user"}]

    @policy[:username] = "test-user"
    @policy[:rolename] = "test-role"
    @policy[:policy_document] = [@policy_document]

  end

  def stub_data
    stub_data = []

    policy = { :client => Aws::IAM::Client,
               :method => :get_policy,
               :data => { :policy => @policy_required }}

    attached_entity = { :client => Aws::IAM::Client,
                        :method => :list_entities_for_policy,
                        :data => { :policy_groups =>  @policy[:attached_groups],
                                   :policy_roles  =>  @policy[:attached_roles],
                                   :policy_users  =>  @policy[:attached_users]}}

    statements = { :client => Aws::IAM::Client,
                        :method => :get_policy_version,
                        :data => {:policy_version => @policy_document}}

    stub_data += [policy]
    stub_data += [attached_entity]
    stub_data += [statements]

  end

  def policy
    @policy
  end
end