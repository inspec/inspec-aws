require 'aws_backend'

class AwsSsmParameters < AwsResourceBase
  name 'aws_ssm_parameters'
  desc 'Verifies settings for a SSM Parameter in bulk.'
  example "
    describe aws_ssm_parameters do
      it { should exist }
    end
  "

  attr_reader :table, :api_response

  FilterTable.create
             .register_column(:names,                field: :name)
             .register_column(:types,                field: :type)
             .register_column(:key_ids,              field: :key_id)
             .register_column(:last_modified_dates,  field: :last_modified_date)
             .register_column(:last_modified_users,  field: :last_modified_user)
             .register_column(:descriptions,         field: :description)
             .register_column(:versions,             field: :version)
             .register_column(:tiers,                field: :tier)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    ssm_parameter_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.ssm_client.describe_parameters(pagination_options)
      end
      return ssm_parameter_rows if !api_response || api_response.empty?

      api_response.parameters.each do |ssm_param|
        ssm_parameter_rows += [{ name:               ssm_param.name,
                                 type:               ssm_param.type,
                                 key_id:             ssm_param.key_id,
                                 last_modified_date: ssm_param.last_modified_date,
                                 last_modified_user: ssm_param.last_modified_user,
                                 description:        ssm_param.description,
                                 version:            ssm_param.version,
                                 tier:               ssm_param.tier,
                                 policies:           ssm_param.policies }]
      end
      break unless api_response.next_token
      pagination_options = { next_token: api_response.next_token }
    end
    @table = ssm_parameter_rows
  end
end
