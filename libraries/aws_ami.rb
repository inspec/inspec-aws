require 'aws_backend'

class AwsAmi < AwsResourceBase
  name 'aws_ami'
  desc 'Verifies settings for an AWS AMI.'

  example "
    describe aws_ami(image_id: 'ami-12345678') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { image_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:image_id])
    @display_name = opts[:image_id]

    catch_aws_errors do
      resp = @aws.compute_client.describe_images({ image_ids: [opts[:image_id]] })
      if resp.images.first.nil?
        empty_response_warn
      else
        ami = resp.images.first.to_h
        @image_id = resp.images[0].image_id
        create_resource_methods(ami)
      end
    end
  end

  def exists?
    !failed_resource?
  end

  # RSpec will alias this to be_public
  def public?
    public
  end

  def resource_id
    @image_id
  end

  def to_s
    "AMI ID #{@display_name}"
  end
end
