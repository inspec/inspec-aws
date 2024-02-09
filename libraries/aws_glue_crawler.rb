require "aws_backend"

class AWSGlueCrawler < AwsResourceBase
  name "aws_glue_crawler"
  desc "Retrieves metadata for a crawler defined in the customer account."

  example "
    describe aws_glue_crawler(name: 'crawler_name') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:name])
    unless opts[:name] && !opts[:name].empty?
      raise ArgumentError, "#{@__resource_name__}: name must be provided"
    end
    @display_name = opts[:name]
    catch_aws_errors do
      resp = @aws.glue_client.get_crawler({ name: opts[:name] })
      @res = resp.crawler.to_h
      create_resource_methods(@res)
    end
  end

  def name
    return unless exists?
    @res[:name]
  end

  def resource_id
    @display_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Crawler Name: #{@display_name}"
  end
end
