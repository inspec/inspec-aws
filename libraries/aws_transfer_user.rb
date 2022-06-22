# frozen_string_literal: true

require 'aws_backend'

class AWSTransferUser < AwsResourceBase
  name 'aws_transfer_user'
  desc 'Describes the user assigned to the specific file transfer protocol-enabled server, as identified by its ServerId property.'
  example "
    describe aws_transfer_user(server_id: 'test', user_name: 'test') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    super(opts)
    validate_parameters(required: %i(server_id user_name))
    raise ArgumentError, "#{@__resource_name__}: server_id must be provided" unless opts[:server_id] && !opts[:server_id].empty?
    raise ArgumentError, "#{@__resource_name__}: user_name must be provided" unless opts[:user_name] && !opts[:user_name].empty?
    @user_name = opts[:user_name]
    catch_aws_errors do
      resp = @aws.transfer_client.describe_user({ server_id: opts[:server_id], user_name: opts[:user_name] })
      @res = resp.user.to_h
      @res[:server_id] = resp.server_id
      create_resource_methods(@res)
    end
  end

  def user_name
    return nil unless exists?
    @res[:user_name]
  end

  def resource_id
    @user_name
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "User Name: #{@user_name}"
  end
end
