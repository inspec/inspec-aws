require 'helper'
require 'aws_hosted_zones'
require 'aws-sdk-core'

class AWSHostedZonesConstructorTest < Minitest::Test

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSHostedZones.new(unexpected: 9) }
  end
end

class AWSHostedZonesSuccessPathTest < Minitest::Test

  def setup
    mock_data = {}
    mock_data[:method] = :list_hosted_zones
    mock_data[:data]   = { hosted_zones:
                              [{name: "test1", id: "test1", caller_reference: "test1"}],
                            marker: "nil", is_truncated: false, next_marker: "nil", max_items: 100}
    mock_data[:client] = Aws::Route53::Client
    @resp = AWSHostedZones.new(client_args: { stub_responses: true }, stub_data: [mock_data])
  end

  def test_hosted_zones_exists
    assert @resp.exist?
  end

  def ids
    assert_equal(@resp.ids, ['test1'])
  end

  def names
    assert_equal(@resp.names, ['test1'])
  end

  def caller_references
    assert_equal(@resp.caller_references, ['test1'])
  end
end
