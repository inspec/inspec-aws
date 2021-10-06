# frozen_string_literal: true

require 'aws_backend'

class AwsCloudFrontKeyGroup < AwsResourceBase
  name 'aws_cloud_front_key_group'
  desc 'Describes one Key Group.'

  example "
    describe aws_cloud_front_key_group(id: 'ID') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:id])

    raise ArgumentError, "#{@__resource_name__}: id must be provided" unless opts[:id] && !opts[:id].empty?
    @display_name = opts[:id]
    catch_aws_errors do
      resp = @aws.cloudfront_client.get_key_group({ id: [opts[:id]] })
      @job_queues = resp.key_group.to_h
      create_resource_methods(@job_queues)
    end
  end

  def id
    return nil unless exists?
    @job_queues[:id]
  end

  def exists?
    !@job_queues.nil? && !@job_queues.empty?
  end

  def to_s
    "Key Group ID: #{@display_name}"
  end
end
