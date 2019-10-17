title "Geth client/service uninstallation default test suite"

describe user('test') do
  it { should_not exist }
end

describe group('test') do
  it { should_not exist }
end

describe directory('/opt/geth') do
  it { should_not exist }
end

describe directory('/etc/geth') do
  it { should_not exist }
end

describe directory('/var/geth') do
  it { should_not exist }
end

describe service('geth') do
  it { should_not be_running }
end

describe file('/etc/systemd/system/geth.service') do
  it { should_not exist }
end
