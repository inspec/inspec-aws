require 'aws-sdk-core'
require 'aws_hosted_zones'

class AwsHostedZonesTests < Minitest::Test

  def test_fail_constructor_values
    assert_raises(ArgumentError) { AwsHostedZones.new('not needed') }
  end
  
  def setup
    data = {}
    data[:method] = :list_hosted_zones
    data[:data] = { hosted_zones: 
                    [{name: "carry-on.films.com", id: "some_random_id", caller_reference: "reference"}], 
                    marker: "nil", is_truncated: false, next_marker: "nil", max_items: 100}
    data[:client] = Aws::Route53::Client

    @zones = AwsHostedZones.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_exists_works
    assert @zones.exist?
  end

  def test_includes_finds
    assert @zones.name.include?("carry-on.films.com")
  end

  def test_count_correct
    assert_equal(@zones.name.count, 1)
  end

  def test_not_included
    refute @zones.name.include?("fast.films.com")
  end
end