<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://retohercules.com/images/ethereum-png-11.png" alt="ethereum logo" title="ethereum" align="right" height="80" /></p>

Ansible Role :computer: :link: Geth
=========
[![Galaxy Role](https://img.shields.io/ansible/role/41457.svg)](https://galaxy.ansible.com/0x0I/geth)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/ansible-role-geth?color=yellow)
[![Downloads](https://img.shields.io/ansible/role/d/41457.svg?color=lightgrey)](https://galaxy.ansible.com/0x0I/geth)
[![Build Status](https://travis-ci.org/0x0I/ansible-role-geth.svg?branch=master)](https://travis-ci.org/0x0I/ansible-role-geth)
[![License: MIT](https://img.shields.io/badge/License-MIT-blueviolet.svg)](https://opensource.org/licenses/MIT)

**Table of Contents**
  - [Supported Platforms](#supported-platforms)
  - [Requirements](#requirements)
  - [Role Variables](#role-variables)
      - [Install](#install)
      - [Config](#config)
      - [Launch](#launch)
      - [Uninstall](#uninstall)
  - [Dependencies](#dependencies)
  - [Example Playbook](#example-playbook)
  - [License](#license)
  - [Author Information](#author-information)

Ansible role that installs, configures and runs [Geth](https://geth.ethereum.org/): a command-line interface and API server for operating an ethereum node.

##### Supported Platforms:
```
* Debian
* MacOS
* Redhat(CentOS/Fedora)
* Ubuntu
```

Requirements
------------

Requires the `unzip/gtar` utility to be installed on the target host. See ansible `unarchive` module [notes](https://docs.ansible.com/ansible/latest/modules/unarchive_module.html#notes) for details.

Role Variables
--------------
Variables are available and organized according to the following software & machine provisioning stages:
* _install_
* _config_
* _launch_
* _uninstall_

#### Install

`geth`can be installed using OS package management systems (e.g `apt`, `homebrew`) or compressed archives (`.tar`, `.zip`) downloaded and extracted from various sources.

_The following variables can be customized to control various aspects of this installation process, ranging from software version and the source location of binaries to the installation directory where they are stored:_

`geth_user: <service-user-name>` (**default**: *geth*)
- dedicated service user and group used by `geth` for privilege separation (see [here](https://www.beyondtrust.com/blog/entry/how-separation-privilege-improves-security) for details)

`install_type: <package | archive>` (**default**: archive)
- **package**: ONLY supported by Ubuntu and MacOS, package installation of Geth pulls the lastest package available for either platform from the [Ubuntu PPA](https://launchpad.net/~ethereum/+archive/ubuntu/ethereum/+packages) (Personal Package Archive) or the [Mac Homebrew formulae repository](https://formulae.brew.sh/formula/ethereum).
  - Note that the installation directory is determined by the package management system and currently defaults to `/usr/bin/geth` for Linux and `/usr/local/bin/geth` for MacOS.
- **archive**: compatible with both **tar and zip** formats, archive installation binaries can be obtained from local and remote compressed archives either from the official download/releases site or by those generated from development or custom versions of the tool.

`archive_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** package containing `geth` binaries. This method technically supports installation of any available version of `geth`. Links to official versions can be found [here](https://geth.ethereum.org/downloads/).

`install_dir: </path/to/installation/dir>` (**default**: see `defaults/main.yml | vars/...`)
- path on target host where the `geth` binaries should be extracted to

#### Config

Configuration of the `geth` client can be expressed in a config file written in [TOML](https://github.com/toml-lang/toml), a minimal markup language, used as an alternative to passing command-line flags at runtime. To get an idea how the config should look you can use the `geth dumpconfig` subcommand to export a client's existing configuration.

_The following variables can be customized to manage the location and content of this TOML configuration:_

`config_dir: </path/to/configuration/dir>` (**default**: `/etc/geth`)
- path on target host where the `geth` TOML configuration should be stored

`geth_config: {"<config-section>": {"<section-setting>": "<setting-value>",..},..}` **default**: see `defaults/main.yml`

* Any configuration setting/value key-pair supported by `geth` should be expressible within the `geth_config` hash and properly rendered within the associated TOML config. Values can be expressed in typical _yaml/ansible_ form (e.g. Strings, numbers and true/false values should be written as is and without quotes).

  Furthermore, configuration is not constrained by hardcoded author defined defaults or limited by pre-baked templating. If the config section, setting and value are recognized by the `geth` tool, :thumbsup: to define within `geth_config`.

  A list of configurable settings can be found [here](https://gist.github.com/0x0I/5887dae3cdf4620ca670e3b194d82cba).

  Keys of the `geth_config` hash represent TOML config sections:
  ```yaml
  geth_config:
    # [TOML Section 'Shh']
    Shh: {}
  ```

  Values of `geth_config[<key>]` represent key,value pairs within an embedded hash expressing config settings:
  ```yaml
  geth_config:
    # TOML Section '[Shh]'
    Shh:
      # Section setting MaxMessageSize with value of 1048576
      MaxMessageSize: 1048576
  ```

#### Launch

Running the `geth` client and API server, either in its RPC, IPC or WS-RPC form, is accomplished utilizing the [systemd](https://www.freedesktop.org/wiki/Software/systemd/) or [launchd](https://www.launchd.info/) service management tools, for Linux and MacOS platforms respectively. Launched as background processes or daemons subject to the configuration and execution potential provided by the underlying management frameworks, the `geth` client and API servers can be set to adhere to system administrative policies right for your environment and organization.

_The following variables can be customized to manage Geth's execution profile/policy:_

`extra_run_args: <geth-cli-options>` (**default**: see `defaults/main.yml`)
- list of `geth` commandline arguments to pass to the binary at runtime for customizing launch.

Supporting full expression of `geth`'s cli, this variable enables the role of target hosts to be customized according to the user's specification; whether to activate a particular API protocol listener, connect to a pre-configured Ethereum test or production network or whatever is supported by `geth`.

  A list of available command-line options can be found [here](https://gist.github.com/0x0I/a06e231d4fd0509ddf3a44f8499a2941).

##### Examples

  Connect to either the Ropsten PoW(proof-of-work) or Rinkeby PoA(proof-of-authory) pre-configured test network:
  ```
  extra_run_args:
    - '--testnet' # PoW
  # ...or...
  extra_run_args:
    - '--rinkeby' # PoA
  ```

  Enhance logging and debugging capabilities for troubleshooting issues:
  ```
  extra_run_args:
    - --debug
    - '--verbosity 5'
    - '--trace /tmp/geth.trace'
  ```

  Enable client and server profiling for analytics and testing purposes:
  ```
  extra_run_args:
    - --pprof
    - '--memprofilerate 1048576'
    - '--blockprofilerate 1'
    - '--cpuprofile /tmp/geth-cpu-profile'
  ```

`custom_unit_properties: <hash-of-systemd-service-settings>` (**default**: `[]`)
- hash of settings used to customize the `[Service]` unit configuration and execution environment of the *Geth* **systemd** service.

#### Uninstall

Support for uninstalling and removing artifacts necessary for provisioning allows for users/operators to return a target host to its configured state prior to application of this role. This can be useful for recycling nodes and roles and perhaps providing more graceful/managed transitions between tooling upgrades.

_The following variable(s) can be customized to manage this uninstall process:_

`perform_uninstall: <true | false>` (**default**: `false`)
- whether to uninstall and remove all artifacts and remnants of this `geth` installation on a target host (**see**: `handlers/main.yml` for details)

Dependencies
------------

- 0x0i.systemd

Example Playbook
----------------
Basic setup with defaults:
```
- hosts: all
  roles:
  - role: 0x0I.geth
```

Launch an Ethereum light client and connect it to the Rinkeby PoA (Proof of Authority) test network:
```
- hosts: light-client
  roles:
  - role: 0x0I.geth
    vars:
      geth_config:
        Eth:
          SyncMode: light
      extra_run_args:
        - --rinkeby
```

Run a full Ethereum node using "fast" sync-mode (only process most recent transactions), enabling both the RPC server interface and client miner and overriding the (block) data directory:
```
- hosts: full-node
  roles:
  - role: 0x0I.geth
    vars:
      geth_config:
        Eth:
          SyncMode: fast
        Node:
          DataDir: /mnt/geth
      extra_run_args:
        - --rpc
        - '--rpcaddr="0.0.0.0'
        - '--mine --miner.threads 16'
```

License
-------

MIT

Author Information
------------------

This role was created in 2019 by O1.IO.
