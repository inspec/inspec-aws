require 'aws_backend'

class AWSServiceCatalogCloudFormationProduct < AwsResourceBase
  name 'aws_servicecatalog_cloud_formation_product'
  desc 'Gets information about the specified product.'

  example "
    describe aws_servicecatalog_cloud_formation_product(name: 'product_name') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:name])
    raise ArgumentError, "#{@__resource_name__}: name must be provided" unless opts[:name] && !opts[:name].empty?
    @display_name = opts[:name]
    catch_aws_errors do
      resp = @aws.servicecatalog_client.describe_product_as_admin({ name: opts[:name] })
      @res = resp.to_h
      @product_view_detail_product_view_summary_id = @res[:product_view_detail][:product_view_summary][:id]
      create_resource_methods(@res)
    end
  end

  def resource_id
    @product_view_detail_product_view_summary_id
  end

  def name
    return unless exists?
    @res[:name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "Product Name: #{@display_name}"
  end
end
