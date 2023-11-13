require 'aws_backend'

class AWSWAFWebACLS < AwsResourceBase
  name 'aws_waf_web_acls'
  desc 'Verifies settings for all the Web ACLs.'

  example "
    describe aws_waf_web_acls do
      it { should exist }
    end
  "

  attr_reader :table

  def initialize(opts = {})
    super(opts)
    validate_parameters
    @table = fetch_data
  end

  FilterTable.create
             .register_column(:web_acl_ids, field: :web_acl_id, style: :simple)
             .register_column(:names, field: :name, style: :simple)
             .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @resp = @aws.waf_client.list_web_acls.map do |table|
        table.map { |table_name| {
          web_acl_id: table_name.web_acls.map(&:web_acl_id),
          name: table_name.web_acls.map(&:name),
        }
        }
      end.flatten
    end
  end
end
