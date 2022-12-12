require "aws_backend"

class AwsSsmAssociation < AwsResourceBase
  name "aws_ssm_association"
  desc "Verifies settings for a SSM Association."

  example "
    describe aws_ssm_association(association_id: 'association-id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(require_any_of: %i(association_id name instance_id))
    @display_name = opts[:association_id]
    catch_aws_errors do
      resp = @aws.ssm_client.describe_association(request_params)
      if resp.association_description.nil?
        empty_response_warn
      else
        @association = resp.association_description.to_h
        @association_id = resp.association_description.association_id
        create_resource_methods(@association)
      end
    end
  end

  def resource_id
    @res? @association_id : @display_name
  end

  def request_params
    opts[:association_id] ? { association_id: opts[:association_id] } : { name: opts[:name], instance_id: opts[:instance_id] }
  end

  def exists?
    !failed_resource?
  end

  def to_s
    "SSM Association ID #{@display_name}"
  end
end
