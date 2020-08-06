require 'helper'
require 'aws_ssm_association'
require 'aws-sdk-ssm'

class AwsSsmAssociationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsSsmAssociation.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsSsmAssociation.new(name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsSsmAssociation.new(unexpected: 9) }
  end

end

class AwsSsmAssociationSuccessPathTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_association
    mock_ssm_association = {}
    mock_ssm_association[:name] = "document-name"
    mock_ssm_association[:association_version] = "1"
    mock_ssm_association[:date] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_ssm_association[:last_update_association_date] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_ssm_association[:overview] = { status: "Success",
                                        detailed_status: "Success",
                                        association_status_aggregated_count: {} }
    mock_ssm_association[:document_version] = "1"
    mock_ssm_association[:association_id] = "association-id-14325423"
    mock_ssm_association[:targets] = [{ key: "instanceids",
                                        values: ["i-52543f43ew234"] }]
    mock_ssm_association[:last_execution_date] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_ssm_association[:last_successful_execution_date] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    data[:data] = { association_description: mock_ssm_association }
    data[:client] = Aws::SSM::Client
    @ssm_association = AwsSsmAssociation.new(association_id: 'association-id-14325423', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ssm_association_exists
    assert @ssm_association.exists?
  end

  def test_ssm_association_name
    assert_equal(@ssm_association.name, 'document-name')
  end

  def test_ssm_association_id
    assert_equal(@ssm_association.association_id, "association-id-14325423")
  end

  def test_ssm_association_version
    assert_equal(@ssm_association.association_version, "1")
  end

  def test_ssm_association_last_execution_date
    assert_equal(@ssm_association.last_execution_date, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end
end