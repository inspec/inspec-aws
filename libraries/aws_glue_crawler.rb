# frozen_string_literal: true

require 'aws_backend'

class AWSGlueCrawler < AwsResourceBase
  name 'aws_glue_crawler'
  desc ''

  example "
    describe aws_glue_crawler(name: 'crawler_name') do
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
      resp = @aws.glue_client.get_crawler({ name: opts[:name] })
      @res = resp.crawler.to_h
      create_resource_methods(@res)
    end
  end

  def id
    return nil unless exists?
    @res[:name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def encrypted?
    @res[:encrypted]
  end

  def to_s
    "crawler name: #{@display_name}"
  end
end
