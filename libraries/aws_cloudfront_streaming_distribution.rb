require 'aws_backend'

class AWSCloudFrontStreamingDistribution < AwsResourceBase
  name 'aws_cloudfront_streaming_distribution'
  desc 'Get the information about a distribution.'

  example "
    describe aws_cloudfront_streaming_distribution(id: 'ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(id))
    raise ArgumentError, "#{@__resource_name__}: id must be provided" unless opts[:id] && !opts[:id].empty?
    @display_name = opts[:id]
    catch_aws_errors do
      resp = @aws.cloudfront_client.get_streaming_distribution({ id: opts[:id] })
      @res = resp.streaming_distribution.to_h
      @arn = @res[:arn]
      create_resource_methods(@res)
    end
  end

  def resource_id
    @arn
  end

  def id
    return nil unless exists?
    @res[:id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def active_aws_account_numbers
    active_trusted_signers.map(&:items).map(&:aws_account_number)
  end

  def active_key_pair_id_quantities
    active_trusted_signers.map(&:items).map(&:key_pair_ids).map(&:quantity)
  end

  def active_key_pair_id_items
    active_trusted_signers.map(&:items).map(&:key_pair_ids).map(&:items)
  end

  def to_s
    "ID: #{@display_name}"
  end
end
