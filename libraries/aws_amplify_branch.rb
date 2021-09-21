# frozen_string_literal: true

require 'aws_backend'

class AWSAmplifyBranch < AwsResourceBase
  name 'aws_amplify_branch'
  desc 'Describes a Amplify Branch.'

  example "
    describe aws_amplify_branch(app_id: 'test1', branch_name: 'test-branch') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { app_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(app_id branch_name))

    raise ArgumentError, "#{@__resource_name__}: app_id must and branch_name be provided" unless opts[:app_id] && !opts[:app_id].empty? && opts[:branch_name] && !opts[:branch_name].empty?
    @display_name = opts[:app_id]
    resp = @aws.amplify_client.get_branch({ app_id: opts[:app_id], branch_name: opts[:branch_name] })
    @apps = resp.branch.to_h
    create_resource_methods(@apps)
  end

  def app_id
    return nil unless exists?
    @apps[:app_id]
  end

  def exists?
    !@apps.nil? && !@apps.empty?
  end

  def to_s
    "Amplify Branch ID : #{@display_name}"
  end
end
