# frozen_string_literal: true
# # frozen_string_literal: true
#
# require 'aws_backend'
#
# class AWSIAMVirtualMFADevice < AwsResourceBase
#   name 'aws_iam_virtual_mfa_device'
#   desc 'Retrieves information about the Virtual MFA Device of a user.'
#
#   example "
#     describe aws_iam_virtual_mfa_device(user_name: 'test1') do
#       it { should exist }
#     end
#   "
#
#   def initialize(opts = {})
#     opts = { user_name: opts } if opts.is_a?(String)
#     super(opts)
#     validate_parameters(required: [:user_name])
#     raise ArgumentError, "#{@__resource_name__}: user_name must be provided" unless opts[:user_name] && !opts[:user_name].empty?
#     @display_name = opts[:user_name]
#     catch_aws_errors do
#       resp = @aws.iam_client.list_mfa_devices({ user_name: opts[:user_name] })
#       @res = resp.instance_profile.to_h
#       create_resource_methods(@res)
#     end
#   end
#
#   def mfa_device
#     return nil unless exists?
#     @res[:mfa_devices]
#   end
#
#   def exists?
#     !@res.nil? && !@res.empty?
#   end
#
#   def to_s
#     "user_name: #{@display_name}"
#   end
# end
#
