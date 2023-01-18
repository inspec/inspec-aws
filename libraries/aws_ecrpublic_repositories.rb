require "aws_backend"

class AwsEcrPublicRepositories < AwsResourceBase
  name "aws_ecrpublic_repositories"
  desc "Verifies settings for a collection of AWS ECR Public Repositories."

  example "
    describe aws_ecrpublic_repositories do
      its('count') { should eq 3 }
    end

    describe aws_ecrpublic_repositories.where(name: 'public-repo') do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
    .register_column(:arns, field: :arn)
    .register_column(:names, field: :name)
    .register_column(:uris, field: :uri)
    .register_column(:created_at_dates, field: :created_at)
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
    ecrpublic_repositories_rows = []
    @query_params[:max_results] = 1000
    loop do
      catch_aws_errors do
        @api_response = @aws.ecrpublic_client.describe_repositories(@query_params)
      end
      return [] if !@api_response || @api_response.empty?

      @api_response.repositories.each do |repo|
        ecrpublic_repositories_rows += [{
          arn: repo.repository_arn,
          name: repo.repository_name,
          uri: repo.repository_uri,
          created_at: repo.created_at,
        }]
      end
      break unless @api_response.next_token
      @query_params[:next_token] = @api_response.next_token
    end
    ecrpublic_repositories_rows
  end
end
