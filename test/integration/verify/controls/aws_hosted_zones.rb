hosted_zone_name = attribute(:aws_route_53_zone)

control "Hosted zones tests" do
  impact  1.0
  title   "Hosted zones"
  desc    "Check hosted zones work"

  describe aws_hosted_zones() do
    it { should exist }
    its ('name') { should include ("#{hosted_zone_name}.")}
  end
end