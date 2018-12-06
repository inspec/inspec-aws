output "aws_vpc_id" {
  value = "${aws_vpc.inspec_vpc.*.id}"
}

output "aws_default_vpc_id" {
  value = "${data.aws_vpc.default.id}"
}

output "aws_instance_id" {
  value = "${aws_instance.linux_ubuntu_vm.*.id}"
}

output "aws_ec2_ami_id" {
  value = "${data.aws_ami.linux_ubuntu.id}"
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

output "aws_ebs_volume_arn" {
  value = "${aws_ebs_volume.inspec_ebs_volume.*.arn}"
}

output "aws_ebs_volume_id" {
  value = "${aws_ebs_volume.inspec_ebs_volume.*.id}"
}

output "aws_kms_key_enabled_id" {
  value = "${aws_kms_key.kms_key_enabled_rotating.*.key_id}"
}

output "aws_kms_key_disabled_id" {
  value = "${aws_kms_key.kms_key_disabled_non_rotating.*.key_id}"
}

output "aws_kms_key_enabled_arn" {
  value = "${aws_kms_key.kms_key_enabled_rotating.*.arn}"
}

output "aws_kms_key_disabled_arn" {
  value = "${aws_kms_key.kms_key_disabled_non_rotating.*.arn}"
}

output "aws_route_table_first_id" {
  value = "${aws_route_table.route_table_first.id}"
}

output "aws_route_table_second_id" {
  value = "${aws_route_table.route_table_second.id}"
}
