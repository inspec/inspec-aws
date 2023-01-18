require "aws_backend"

class AwsEcrRepositories < AwsResourceBase
  name "aws_ecr_repositories"
  desc "Verifies settings for a collection of AWS ECR Repositories."

  example "
    describe aws_ecr_repositories do
      its('count') { should eq 3 }
    end

    describe aws_ecr_repositories.where(name: 'my-repo') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:arns, field: :arn)
    .register_column(:names, field: :name)
    .register_column(:uris, field: :uri)
    .register_column(:created_at_dates, field: :created_at)
    .register_column(:image_tag_mutability_status, field: :image_tag_mutability)
    .register_column(:image_scanning_on_push_status, field: :image_scanning_on_push_status)
    .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters(allow: %i(registry_id))
    @query_params = {}
    # Validate registry_id. (Optional. If not provided, AWS account ID will be used by the AWS API.)
    if opts.key?(:registry_id)
      raise ArgumentError, "#{@__resource_name__}: `registry_id` should be a string of 12 digits." unless /^[0-9]{12}$/.match?(opts[:registry_id])
      @query_params[:registry_id] = opts[:registry_id]
    end
    @table = fetch_data
  end

  def fetch_data
    ecr_repositories_rows = []
    @query_params[:max_results] = 1000
    loop do
      catch_aws_errors do
        @api_response = @aws.ecr_client.describe_repositories(@query_params)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.repositories.each do |repo|
        ecr_repositories_rows += [{
          arn: repo.repository_arn,
          name: repo.repository_name,
          uri: repo.repository_uri,
          created_at: repo.created_at,
          image_tag_mutability: repo.image_tag_mutability,
          image_scanning_on_push_status: repo.image_scanning_configuration.scan_on_push,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    ecr_repositories_rows
  end
end
