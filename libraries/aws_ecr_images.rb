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
             .register_column(:size_in_bytes, field: :size_in_bytes)
             .register_column(:pushed_at_dates, field: :pushed_at_date)
             .register_column(:vulnerability_scan_status, field: :vulnerability_scan_status)
             .register_column(:vulnerability_severity_counts, field: :vulnerability_severity_counts)
             .install_filter_methods_on_resource(self, :table)


  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(repository_name))
    @table = fetch_data
  end

  def fetch_data
    ecr_images_rows = []
    query_params = { repository_name: opts[:repository_name], max_results: 1000 }
    loop do
      catch_aws_errors do
        @api_response = @aws.ecr_client.describe_images(query_params)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.image_details.each do |image|
        ecr_images_rows += [{
          digest: image.image_digest,
          tags: image.image_tags,
          size_in_bytes: image.image_size_in_bytes,
          pushed_at_date: image.image_pushed_at,
          vulnerability_scan_status: image.image_scan_status ? image.image_scan_status.status : nil,
          vulnerability_severity_counts:
              image.image_scan_findings_summary ? image.image_scan_findings_summary.finding_severity_counts : nil,
        }]
      end
      break unless @api_response.next_token
      query_params[:next_token] = @api_response.next_token
    end
    ecr_images_rows
  end
end