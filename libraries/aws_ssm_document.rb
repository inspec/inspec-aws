require 'aws_backend'

class AwsSsmDocument < AwsResourceBase
  name 'aws_ssm_document'
  desc 'Verifies settings for a SSM Document.'

  example "
    describe aws_ssm_document(name: 'document-name') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:name])
    @display_name = opts[:name]

    catch_aws_errors do
      resp = @aws.ssm_client.describe_document({ name: opts[:name] })

      if resp.document.nil?
        empty_response_warn
      else
        @document = resp.document.to_h
        @document[:document_hash] = @document.delete(:hash)
        @document[:hash] = @document.hash
        create_resource_methods(@document)
      end
    end
  end

  def resource_id
    @document[:hash]
  end

  def exists?
    !failed_resource?
  end

  def to_s
    "SSM Document Name #{@display_name}"
  end
end
