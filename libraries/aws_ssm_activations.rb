require 'aws_backend'

class AwsSsmActivations < AwsResourceBase
  name 'aws_ssm_activations'
  desc 'Verifies settings for a SSM Activation in bulk.'
  example "
    describe aws_ssm_activations do
      it { should exist }
    end
  "

  attr_reader :table, :api_response

  FilterTable.create
             .register_column(:activation_ids,         field: :activation_id)
             .register_column(:descriptions,           field: :description)
             .register_column(:default_instance_names, field: :default_instance_name)
             .register_column(:iam_roles,              field: :iam_role)
             .register_column(:registration_limits,    field: :registration_limit)
             .register_column(:registrations_count,    field: :registrations_count)
             .register_column(:expiration_dates,       field: :expiration_date)
             .register_column(:expired,                field: :expired)
             .register_column(:created_dates,          field: :created_date)
             .register_column(:tags,                   field: :tags)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    ssm_activation_rows = []
    pagination_options = {}
    loop do
      catch_aws_errors do
        @api_response = @aws.ssm_client.describe_activations(pagination_options)
      end
      return ssm_activation_rows if !api_response || api_response.empty?
      api_response.activation_list.each do |ssm_activation|
        ssm_activation_rows += [{ activation_id:         ssm_activation.activation_id,
                                  description:           ssm_activation.description,
                                  default_instance_name: ssm_activation.default_instance_name,
                                  iam_role:              ssm_activation.iam_role,
                                  registration_limit:    ssm_activation.registration_limit,
                                  registrations_count:   ssm_activation.registrations_count,
                                  expiration_date:       ssm_activation.expiration_date,
                                  expired:               ssm_activation.expired,
                                  created_date:          ssm_activation.created_date,
                                  tags:                  ssm_activation.tags }]
      end
      break unless api_response.next_token
      pagination_options = { next_token: api_response.next_token }
    end
    @table = ssm_activation_rows
  end
end
