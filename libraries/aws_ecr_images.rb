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
    validate_parameters(required: %i(repository_name), allow: %i(registry_id))
    @query_params = {}
    # Validate repository_name.
    pattern = %r{(?:[a-z0-9]+(?:[._-][a-z0-9]+)*/)*[a-z0-9]+(?:[._\-][a-z0-9]+)*}
    matched_str = opts[:repository_name].match(pattern)
    unless (opts[:repository_name] == matched_str[0]) && (matched_str.length == 1) && opts[:repository_name].length.between?(2, 256)
      raise ArgumentError, "#{@__resource_name__}: `repository_name` is not in a valid format. " \
                           'Please check the docs for more info '\
                           'https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_DescribeRepositories.html' \
    end
    @query_params[:repository_name] = opts[:repository_name]
    # Validate registry_id. (Optional. If not provided, AWS account ID will be used by the AWS API.)
    if opts.key?(:registry_id)
      raise ArgumentError, "#{@__resource_name__}: `registry_id` should be a string of 12 digits." unless /^[0-9]{12}$/.match?(opts[:registry_id])
      @query_params[:registry_id] = opts[:registry_id]
    end
    @table = fetch_data
  end

  def fetch_data
    ecr_images_rows = []
    @query_params[:max_results] = 1000
    loop do
      catch_aws_errors do
        @api_response = @aws.ecr_client.describe_images(@query_params)
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
      @query_params[:next_token] = @api_response.next_token
    end
    ecr_images_rows
  end
end
