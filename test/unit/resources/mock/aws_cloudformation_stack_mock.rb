require_relative 'aws_base_resource_mock'

class AwsCloudFormationStackMock < AwsBaseResourceMock

  def initialize
    super
    @cf = {stacks: [{stack_name: @aws.any_string,
                     stack_id: @aws.any_string,
                     change_set_id: @aws.any_string,
                     description: @aws.any_string,
                     parameters: [{:parameter_key=>"key", :parameter_value=>"value", :resolved_value=>"value", :use_previous_value=>true}],
                     creation_time: Time.now,
                     deletion_time: Time.now,
                     last_updated_time: Time.now,
                     rollback_configuration: {:monitoring_time_in_minutes => @aws.any_int, :rollback_triggers =>[{:arn=>@aws.any_arn, :type=>@aws.any_string}]},
                     stack_status: @aws.any_string,
                     stack_status_reason: @aws.any_string,
                     drift_information: {:stack_drift_status => "status"},
                     disable_rollback: true,
                     notification_arns: @aws.any_array_of_string,
                     timeout_in_minutes: @aws.any_int,
                     capabilities: @aws.any_array_of_string,
                     outputs: [{:description=>"test description", :export_name=>"export name", :output_key=>"test key", :output_value=>"output value"}],
                     role_arn: @aws.any_string,
                     tags: [{:key=>@aws.any_string, :value=>@aws.any_string}],
                     enable_termination_protection: true,
                     parent_id: @aws.any_string,
                     root_id: @aws.any_string,
                    }]}
  end

  def stub_data
    stub_data = []
    cf = {:client => Aws::CloudFormation::Client,
              :method => :describe_stacks,
              :data => @cf}

    stub_data += [cf]
  end

  def cf
    @cf
  end
end