title "Geth TOML configuration default test suite"

describe file('/etc/geth/config.toml') do
  it { should exist }
  its('content') { should match("[Eth]") }
  its('content') { should match("[Node]") }
  its('content') { should match('SyncMode = "full"') }
  its('content') { should match('DataDir = "/var/test/geth"') }
end