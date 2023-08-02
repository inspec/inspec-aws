control "xccdf_org.cisecurity.benchmarks_rule_1.6.4_Ensure_prelink_is_disabled" do
  title "Ensure prelink is disabled"
  desc  "
    prelink is a program that modifies ELF shared libraries and ELF dynamically linked binaries in such a way that the time needed for the dynamic linker to perform relocations at startup significantly decreases.

    Rationale: The prelinking feature can interfere with the operation of AIDE, because it changes binaries. Prelinking can also increase the vulnerability of the system if a malicious user is able to compromise a common library such as libc.
  "
  impact 1.0
  describe package("prelink") do
    it { should_not be_installed }
  end
end


control "xccdf_org.cisecurity.benchmarks_rule_5.1.1_Ensure_cron_daemon_is_enabled_and_running" do
  title "Ensure cron daemon is enabled and running"
  desc  "
    The cron daemon is used to execute batch jobs on the system.

    Rationale: While there may not be user jobs that need to be run on the system, the system does have maintenance jobs that may include security monitoring that have to run. If another method for scheduling tasks is not being used, cron is used to execute them, and needs to be enabled and running.
  "
  impact 1.0
  describe.one do
    describe service('cron') do
      it { should be_enabled }
      it { should be_running }
    end
    describe package("cronie") do
      it { should_not be_installed }
    end
  end
end



control "xccdf_org.cisecurity.benchmarks_rule_5.1.7_Ensure_permissions_on_etccron.d_are_configured" do
  title "Ensure permissions on /etc/cron.d are configured"
  desc  "
    The /etc/cron.d/ directory contains system cron jobs that need to run in a similar manner to the hourly, daily weekly and monthly jobs from /etc/crontab , but require more granular control as to when they run. The files in this directory cannot be manipulated by the crontab command, but are instead edited by system administrators using a text editor. The commands below restrict read/write and search access to user and group root, preventing regular users from accessing this directory.

    Rationale: Granting write access to this directory for non-privileged users could provide them the means for gaining unauthorized elevated privileges. Granting read access to this directory could give an unprivileged user insight in how to gain elevated privileges or circumvent auditing controls.
  "
  impact 1.0
  if package('cronie').installed?
    describe file("/etc/cron.d") do
      it { should exist }
    end
    describe file("/etc/cron.d") do
      it { should_not be_executable.by "group" }
    end
    describe file("/etc/cron.d") do
      it { should_not be_readable.by "group" }
    end
    describe file("/etc/cron.d") do
      its("gid") { should cmp 0 }
    end
    describe file("/etc/cron.d") do
      it { should_not be_writable.by "group" }
    end
    describe file("/etc/cron.d") do
      it { should_not be_executable.by "other" }
    end
    describe file("/etc/cron.d") do
      it { should_not be_readable.by "other" }
    end
    describe file("/etc/cron.d") do
      it { should_not be_writable.by "other" }
    end
    describe file("/etc/cron.d") do
      its("uid") { should cmp 0 }
    end
  else
    describe package("cronie") do
      it { should_not be_installed }
    end
  end
end


control "xccdf_org.cisecurity.benchmarks_rule_5.2.9_Ensure_SSH_HostbasedAuthentication_is_disabled" do
  title "Ensure SSH HostbasedAuthentication is disabled"
  desc  "
    The HostbasedAuthentication parameter specifies if authentication is allowed through trusted hosts via the user of .rhosts , or /etc/hosts.equiv , along with successful public key client host authentication. This option only applies to SSH Protocol Version 2.

    Rationale: Even though the .rhosts files are ineffective if support is disabled in /etc/pam.conf , disabling the ability to use .rhosts files in SSH provides an additional layer of protection.
  "
  impact 1.0
  describe.one do
    describe sshd_config do
      its('HostbasedAuthentication') { should eq 'no' }
    end
    describe package('openssh') do
      it { should_not be_installed }
    end
  end
end



control "xccdf_org.cisecurity.benchmarks_rule_5.4.1.3_Ensure_minimum_days_between_password_changes_is_configured" do
  title "Ensure minimum days between password changes is configured"
  desc  "
    The PASS_MIN_DAYS parameter in /etc/login.defs allows an administrator to prevent users from changing their password until a minimum number of days have passed since the last time the user changed their password. It is recommended that PASS_MIN_DAYS parameter be set to 1 or more days.

    Rationale: By restricting the frequency of password changes, an administrator can prevent users from repeatedly changing their password in an attempt to circumvent password reuse controls.
  "
  impact 1.0
  describe file("/etc/login.defs") do
    its("content") { should match(/^\s*PASS_MIN_DAYS\s+([1-9]|[1-9][0-9]+)\s*(\s+#.*)?$/) }
  end
  describe file("/etc/shadow") do
    its("content") { should_not match(/^\S+:[^\!\*:]*:[^:]*:(0|\-1):[^:]*:[^:]*:[^:]*:[^:]*:[^:]*\s*$/) }
  end
end