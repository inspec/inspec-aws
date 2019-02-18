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

    @policy_document = {}
    @policy_document[:document] = @aws.any_string
    @policy_document[:version_id] = "v5"
    @policy_document[:is_default_version] = true

    @policy = Hash[@policy_required]
    @policy[:attached_groups] = []
    @policy[:attached_roles] = []
    @policy[:attached_users] = []

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