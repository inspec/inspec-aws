require 'aws_backend'

class AWSElasticSearchServiceDomain < AwsResourceBase
  name 'aws_elasticsearchservice_domain'
  desc 'Returns domain configuration information about the specified Elasticsearch domain, including the domain ID, domain endpoint, and domain ARN.'

  example "
    describe aws_elasticsearchservice_domain(domain_name: 'DomainName') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { domain_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:domain_name])
    raise ArgumentError, "#{@__resource_name__}: domain_name must be provided" unless opts[:domain_name] && !opts[:domain_name].empty?
    @display_name = opts[:domain_name]
    catch_aws_errors do
      resp = @aws.elasticsearch_service_client.describe_elasticsearch_domain({ domain_name: opts[:domain_name] })
      @domain_status = resp.domain_status.to_h
      create_resource_methods(@domain_status)
    end
  end

  def domain_name
    return unless exists?
    @domain_status[:domain_name]
  end

  def resource_id
    @domain_status? @domain_status[:domain_id]: ''
  end

  def exists?
    !@domain_status.nil? && !@domain_status.empty?
  end

  def to_s
    "Domain Name: #{@display_name}"
  end
end
