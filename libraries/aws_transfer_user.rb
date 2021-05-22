# frozen_string_literal: true

require 'aws_backend'

class AWSTransferUser < AwsResourceBase
  name 'aws_transfer_user'
  desc ''

  example `
    describe aws_transfer_user(server_id: "value", user_name: 'value') do
      it { should exist }
    end
  `

  def initialize(opts = {})
    opts = { server_id: opts, user_name: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(server_id user_name))
    raise ArgumentError, "#{@__resource_name__}: server_id must be provided" unless opts[:server_id] && !opts[:server_id].empty?
    raise ArgumentError, "#{@__resource_name__}: user_name must be provided" unless opts[:user_name] && !opts[:user_name].empty?
    @user_name = opts[:user_name]
    catch_aws_errors do
      resp = @aws.transfer_client.describe_user({ server_id: opts[:server_id], user_name: opts[:user_name] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def id
    return nil unless exists?
    @res[:user_name]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def encrypted?
    @res[:encrypted]
  end

  def to_s
    "user_name: #{@user_name}"
  end
end
