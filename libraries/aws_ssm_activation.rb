# frozen_string_literal: true

require 'aws_backend'

class AwsSsmActivation < AwsResourceBase
  name 'aws_ssm_activation'
  desc 'Verifies settings for a SSM Activation'

  example "
    describe aws_ssm_activation(activation_id: 'activation-id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { activation_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:activation_id])
    @display_name = opts[:activation_id]

    catch_aws_errors do
      filter = { filter_key: 'ActivationIds', filter_values: [opts[:activation_id]] }
      resp = @aws.ssm_client.describe_activations({ filters: [filter] })
      if resp.activation_list.first.nil?
        empty_response_warn
      else
        @activation = resp.activation_list.first.to_h
        create_resource_methods(@activation)
      end
    end
  end

  def exists?
    !failed_resource?
  end

  def to_s
    "SSM Activation ID #{@display_name}"
  end
end
