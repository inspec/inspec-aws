require 'aws_backend'

class AWSElasticSearchServiceDomains < AwsResourceBase
  name 'aws_elasticsearchservice_domains'
  desc 'Gets details about a particular identity pool, including the pool name, ID description, creation date, and current number of users.'

  example "
    describe aws_elasticsearchservice_domains do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:domain_names,        field: :domain_name)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @domain_names = @aws.elasticsearch_service_client.list_domain_names
    end
    return [] if !@domain_names || @domain_names.empty?
    @table = @domain_names.domain_names.map(&:to_h)
  end
end
