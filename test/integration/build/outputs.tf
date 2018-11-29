output "aws_vpc_id" {
  value = "${aws_vpc.inspec_vpc.*.id}"
}

output "aws_default_vpc_id" {
  value = "${data.aws_vpc.default.id}"
}

output "aws_instance_id" {
  value = "${aws_instance.linux_ubuntu_vm.*.id}"
}

output "aws_vpc_dhcp_options_id" {
  value = "${aws_vpc.inspec_vpc.*.dhcp_options_id}"
}

output "aws_subnet_id" {
  value = "${aws_subnet.inspec_subnet.*.id}"
}

output "aws_subnet_cidr_block" {
  value = "${aws_subnet.inspec_subnet.*.cidr_block}"
}