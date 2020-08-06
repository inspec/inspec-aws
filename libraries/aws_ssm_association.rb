# frozen_string_literal: true

require 'aws_backend'

class AwsSsmAssociation < AwsResourceBase
  name 'aws_ssm_association'
  desc 'Verifies settings for a SSM Association'

  example "
    describe aws_ssm_association(association_id: 'association-id') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { association_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:association_id])
    @display_name = opts[:association_id]
    catch_aws_errors do
      resp = @aws.ssm_client.describe_association({ association_id: opts[:association_id] })
      if resp.association_description.nil?
        empty_response_warn
      else
        @association = resp.association_description.to_h
        create_resource_methods(@association)
      end
    end
  end

  def exists?
    !failed_resource?
  end

  def to_s
    "SSM Association ID #{@display_name}"
  end

  def name
    name if exists?
  end
end
