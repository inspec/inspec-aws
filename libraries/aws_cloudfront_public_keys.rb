# frozen_string_literal: true

require 'aws_backend'

class AWSCloudFrontPublicKeys < AwsResourceBase
  name 'aws_cloudfront_public_keys'
  desc 'Lists all Public Keys.'

  example "
    describe aws_cloudfront_public_keys do
      it { should exist }
    end
  "

  attr_reader :table

  FilterTable.create
             .register_column(:ids, field: :id)
             .register_column(:names, field: :name)
             .register_column(:created_time, field: :created_time)
             .register_column(:encoded_keys, field: :encoded_key)
             .register_column(:comments, field: :comment)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  def fetch_data
    catch_aws_errors do
      @table = @aws.cloudfront_client.list_public_keys.map do |table|
        table.public_key_list.map { |table_name| {
          id: table_name.items.map(&:id),
          created_time: table_name.items.map(&:created_time),
          name: table_name.items.map(&:name),
          encoded_key: table_name.items.map(&:encoded_key),
          comment: table_name.items.map(&:comment),
        }
        }
      end.flatten
    end
  end
end
