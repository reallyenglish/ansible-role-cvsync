require "spec_helper"
require "serverspec"

package = "cvsync"
config  = "/etc/cvsync.conf"
user    = "_cvsyncd"
group   = "_cvsyncd"
base_prefix = "/home/vagrant/cvs"
hostname = "cvsync.allbsd.org"
default_user = "root"
default_group = "wheel"

describe package(package) do
  it { should be_installed }
end

describe file(config) do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
  its(:content) { should match(/^\s+base-prefix #{Regexp.escape(base_prefix)}$/) }
  its(:content) { should match(/^\s+hostname #{Regexp.escape(hostname)}$/) }
  its(:content) { should match(/^\s+collection {\n\s+name tendra-www release rcs$/) }
end

describe file(base_prefix) do
  it { should exist }
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe command("su -l -s /bin/sh #{user}  -c '/usr/local/bin/cvsync -c #{config}'") do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq "" }
end
describe file("#{base_prefix}/www") do
  it { should exist }
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end
describe file("#{base_prefix}/www/en/Makefile,v") do
  it { should exist }
  it { should be_file }
  it { should be_mode 444 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end
