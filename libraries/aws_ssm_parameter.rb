require "aws_backend"

class AwsSsmParameter < AwsResourceBase
  name "aws_ssm_parameter"
  desc "Verifies settings for a SSM Parameter."

  example "
    describe aws_ssm_parameter(name: 'parameter-name') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:name], allow: [:with_decryption])
    @display_name = opts[:name]
    catch_aws_errors do
      resp = @aws.ssm_client.get_parameter(request_params)

      if resp.parameter.nil?
        empty_response_warn
      else
        @ssm_parameter = resp.parameter.to_h
        @ssm_parameter_arn = @ssm_parameter[:arn]
        create_resource_methods(@ssm_parameter)
      end
    end
  end

  def resource_id
    @ssm_parameter_arn
  end

  def request_params
    opts[:with_decryption] ? { name: opts[:name], with_decryption: true } : { name: opts[:name] }
  end

  def exists?
    !failed_resource?
  end

  def to_s
    "SSM Parameter Name #{@display_name}"
  end

  def name
    name if exists?
  end
end
