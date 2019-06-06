Ansible Role :link: Geth
=========

Ansible role that installs, configures and runs as a service, Geth: a command-line interface for running an ethereum node.

##### Supported Platforms:
```
* CentOS/Fedora/RHEL
* Debian/Ubuntu
* MacOS
```

Requirements
------------

Requires the `unzip/gtar` utility to be installed on the server. See ansible `unarchive` module [notes](https://docs.ansible.com/ansible/latest/modules/unarchive_module.html#notes) for details.

Role Variables
--------------
Variables are available and organized according to the following software & machine provisioning stages:
* _install_
* _config_
* _startup_
* _cleanup_

##### __[Install]__
_`geth` can be installed using OS package management systems (e.g `apt-get`, `homebrew`) and download/extractions from source compressed packages (`.tar`, `.zip`)._

_The following variables can be customized to control various aspects of this installation process, ranging from software version and the source location of binaries to the installation directory where they are stored:_

`install_type: <package | source>` (**default**: source)
- **package**: ONLY supported by Ubuntu and MacOS, package installation of Geth pulls the lastest package available for either platform from the [Ubuntu PPA](https://launchpad.net/~ethereum/+archive/ubuntu/ethereum/+packages) (Personal Package Archive) or the [Mac Homebrew formulae repository](https://formulae.brew.sh/formula/ethereum).
  - Note that the installation directory is determined by the package management system and currently defaults to `/usr/bin/geth` for Linux and `/usr/local/bin/geth` for MacOS. Attempts to set and execute a package installation on other Linux distros will result in failure due to lack of support.
- **source**: compatible with both **tar and zip** formats, source installation binaries can be obtained from local and remote compressed archives either from the official download or releases site or by those generated from development or custom versions of the tool.

`install_src: <path-or-url-to-src>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** package containing `geth` binaries. This method technically supports installation of any available version of `geth`. Links to official versions can be found [here](https://geth.ethereum.org/downloads/).

`install_dir: </path/to/installation/dir>` (**default**: see `defaults/main.yml | vars/main.yml`)
- path on remote host where the `geth` binaries should be extracted to

##### __[Config]__

_Configuration of the `geth` client can be expressed in [TOML](https://github.com/toml-lang/toml), a minimal markup language used as an alternative to passing command-line flags at runtime. To get an idea how the config should look you can use the `geth dumpconfig` subcommand to export a client's existing configuration._

_The following variables can be customized to manage the location and content of this TOML configuration:_

`config_dir: </path/to/configuration/dir>` (**default**: see `/etc/geth`)
- path on remote host where the `geth` TOML configuration should be stored

`geth_config: {"<config-section>": {"<section-setting>": "<setting-value>",..},..}`

**default**: see `defaults/main.yml | vars/main.yml`

* Any configuration setting/value key-pair supported by `geth` should be expressible within the `geth_config` hash and properly rendered within the associated TOML config file
* Setting values can be expressed in typical _yaml/ansible_ form (i.e. Strings, numbers and true/false values should be written as is and without quotes)
* Configuration is not constrained by hardcoded author defined defaults or limited by pre-baked templating. If the config section, setting and value are recognized by the `geth` tool, it's :thumbsup: to define within `geth_config`. An example of the full list of configuratable settings can be found [here](https://gist.github.com/0x0I/5887dae3cdf4620ca670e3b194d82cba).
* Keys of the `geth_config` hash represent TOML config sections
  ```yaml
  geth_config:
    # [TOML Section 'Shh']
    Shh: {}
  ```
* Values of `geth_config[<key>]` represent key,value pairs within an embedded hash expressing config settings and values
  ```yaml
  geth_config:
    # TOML Section '[Shh]'
    Shh:
      # Section setting MaxMessageSize with value of 1048576
      MaxMessageSize: 1048576
  ```

##### __[Startup]__
...

##### __[Cleanup]__
...

Dependencies
------------

None

Example Playbook
----------------
Basic setup with defaults:
```
- hosts: all
  roles:
  - role: 0xO1.geth
```

Run a full Ethereum node using "fast" sync-mode (only process most recent transactions) and enabling both the RPC server interface and client miner:
```
- hosts: all
  roles:
  - role: 0xO1.geth
    vars:
      geth_config:
        Eth:
          SyncMode: fast
        Node:
          DataDir: /mnt/geth
      extra_run_args: '--config /etc/geth/config.toml --rpc --rpcaddr="0.0.0.0" --mine --miner.threads 16'
```

License
-------

Apache, BSD, MIT

Author Information
------------------

This role was created in 2019 by O1 Labs.
