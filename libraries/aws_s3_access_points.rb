require 'aws_backend'

class AWSS3AccessPoints < AwsResourceBase
  name 'aws_s3_access_points'
  desc 'List one or more S3 Access Points.'

  example "
    describe aws_s3_access_points(bucket_name: 'BucketName') do
      it { should exits }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids, field: :id)
             .register_column(:filter_access_point_arns, field: :filter_access_point_arn)
             .register_column(:filter_and_access_point_arns, field: :filter_and_access_point_arn)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(bucket_name))
    @query_params = {}
    raise ArgumentError, "#{@__resource_name__}: bucket_name must be provided" unless opts[:bucket_name] && !opts[:bucket_name].empty?
    @query_params[:bucket] = opts[:bucket_name]
    @table = fetch_data
  end

  def fetch_data
    rows = []
    loop do
      catch_aws_errors do
        @api_response = @aws.storage_client.list_bucket_metrics_configurations(@query_params)
      end
      return rows if !@api_response || @api_response.empty?
      @api_response.metrics_configuration_list.each do |resp|
        rows += [{ id: resp.id,
                   filter_access_point_arn: resp.filter.access_point_arn,
                   filter_and_access_point_arn: resp.filter.and.access_point_arn }]
      end
      break unless @api_response.is_truncated
      @query_params[:continuation_token] = @api_response.continuation_token
    end
    rows
  end
end
