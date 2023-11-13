require 'aws_backend'

class AwsIamPolicies < AwsResourceBase
  name 'aws_iam_policies'
  desc 'Verifies settings for a collection AWS IAM Policies.'
  example "
    describe aws_iam_policies do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:arns,                field: :arn)
             .register_column(:attachment_counts,   field: :attachment_count)
             .register_column(:default_version_ids, field: :default_version_id)
             .register_column(:policy_names,        field: :policy_name)
             .register_column(:policy_ids,          field: :policy_id)
             .register_column(:attached_groups,     field: :attached_groups)
             .register_column(:attached_roles,      field: :attached_roles)
             .register_column(:attached_users,      field: :attached_users)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(allow: %i(only_attached scope))
    parameters = {}
    parameters[:only_attached] = opts[:only_attached] if opts[:only_attached]
    parameters[:scope]         = opts[:scope]         if opts[:scope]
    @table = fetch_data(parameters)
  end

  def fetch_data(parameters = {})
    iam_policy_rows = []
    loop do
      catch_aws_errors do
        @response = @aws.iam_client.list_policies(parameters)
      end
      return [] if !@response || @response.empty?
      @response.policies.each do |p|
        criteria = { policy_arn: p.arn }
        policy_entity = @aws.iam_client.list_entities_for_policy(criteria)
        iam_policy_rows += [{ arn:                p.arn,
                              attachment_count:   p.attachment_count,
                              default_version_id: p.default_version_id,
                              policy_name:        p.policy_name,
                              policy_id:          p.policy_id,
                              attached_groups:    policy_entity.policy_groups.map(&:group_name),
                              attached_roles:     policy_entity.policy_roles.map(&:role_name),
                              attached_users:     policy_entity.policy_users.map(&:user_name) }]
      end
      break unless @response.is_truncated
      break unless @response.marker
      parameters[:marker] = @response.marker
    end
    @table = iam_policy_rows
  end
end
