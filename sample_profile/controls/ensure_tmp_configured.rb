control "xccdf_org.cisecurity.benchmarks_rule_1.1.2_Ensure_tmp_is_configured" do
  title "Ensure /tmp is configured"
  desc  "
    The /tmp directory is a world-writable directory used for temporary storage by all users and some applications.

    **Notes:**

    * **If an entry for /tmp exists in /etc/fstab it will take precedence over entries in the tmp.mount file.**
    * **tmpfs can be resized using the size={size} parameter in /etc/fstab or on the Options line in the tmp.mount file. If we don't specify the size, it will be half the RAM. **
    ** Resize tmpfs examples: **

    * **/etc/fstab**
    tmpfs   /tmp         tmpfs   rw,noexec,nodev,nosuid,size=2G          0  0 * **tmp.mount**
    [Mount]
    What=tmpfs
    Where=/tmp
    Type=tmpfs
    Options=mode=1777,strictatime,size=2G,noexec,nodev,nosuid

    Rationale: Making /tmp its own file system allows an administrator to set the noexec option on the mount, making /tmp useless for an attacker to install executable code. It would also prevent an attacker from establishing a hardlink to a system setuid program and wait for it to be updated. Once the program was updated, the hardlink would be broken and the attacker would have his own copy of the program. If the program happened to have a security vulnerability, the attacker could continue to exploit the known flaw.

    This can be accomplished by either mounting tmpfs to /tmp, or creating a separate partition for /tmp.
  "
  impact 1.0
  describe mount("/tmp") do
    it { should be_mounted }
  end
end