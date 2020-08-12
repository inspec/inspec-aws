# frozen_string_literal: true

require 'aws_backend'

class AwsEc2Image < AwsResourceBase
  name 'aws_ec2_image'
  desc 'Verifies settings for an AWS EC2 image'

  example "
    describe aws_ec2_image(image_id: 'ami-12345678') do
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
        @ami = resp.images[0].to_h
        create_resource_methods(@ami)
      end
    end
  end

  def exists?
    !failed_resource?
  end

  def to_s
    "EC2 Image ID #{@display_name}"
  end
end
