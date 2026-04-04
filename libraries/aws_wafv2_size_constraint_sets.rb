require "aws_backend"

class AWSWAFV2SizeConstraintSets < AwsResourceBase
  name "aws_wafv2_size_constraint_sets"
  desc "Describes all the WAF size constraint sets."

  example "
    describe aws_wafv2_size_constraint_set do
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
    .register_column(:size_constraint_set_ids, field: :size_constraint_set_id, style: :simple)
    .register_column(:names, field: :name, style: :simple)
    .install_filter_methods_on_resource(self, :table)

  def fetch_data
    catch_aws_errors do
      @resp = @aws.waf_client_v2.list_size_constraint_sets.map do |table|
        table.map { |table_name| {
          name: table_name.size_constraint_sets.map(&:name),
          size_constraint_set_id: table_name.size_constraint_sets.map(&:size_constraint_set_id),
        }
        }
      end.flatten
    end
  end
end
