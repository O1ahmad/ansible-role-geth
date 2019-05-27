title "Geth TOML configuration default test suite"

describe file('/etc/geth/geth.toml') do
  it { should exist }
end