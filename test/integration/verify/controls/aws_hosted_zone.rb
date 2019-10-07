
hosted_zone_name = attribute(:aws_route_53_zone)

control "Hosted zone validation" do
  impact  1.0
  title   "Hosted zone validation"
  desc    "Confirm hosted zone tests are correct"

  describe aws_hosted_zone("#{hosted_zone_name}.") do
    it { should exist }
    its ('private_zone') { should be true}
    its ('name_servers.count') { should eq 0}
    its ('record_names') { should include "www.carry-on-films.com.#{hosted_zone_name}." }
  end
  
end