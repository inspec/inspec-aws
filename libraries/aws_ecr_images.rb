# frozen_string_literal: true

require 'aws_backend'

class AwsEcrImages < AwsResourceBase
  name 'aws_ecr_images'
  desc 'Verifies settings for a collection of AWS ECR Images in a repository.'

  example "
    describe aws_ecr_images(repository_name: 'my-repo') do
      its('count') { should eq 3 }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:digests, field: :digest)
             .register_column(:tags, field: :tags)
             .register_column(:size_in_bytes, field: :size_in_byte)
             .register_column(:pushed_at_dates, field: :pushed_at_date)
             .register_column(:vulnerability_scan_status, field: :vulnerability_scan_status)
             .register_column(:scan_status, field: :scan_status)
            .install_filter_methods_on_resource(self, :table)


  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(repository_name))
    @display_name = opts.values.first
    catch_aws_errors do
      resp = @aws.ecr_client.describe_images(
        repository_name: opts[:repository_name],
      )
      @image = resp.image_details.first.to_h
      create_resource_methods(@image)
    end
  end

  def exists?
    !@image.nil?
  end

  def to_s
    "ECR Image #{@display_name}"
  end
end