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
* install
* config
* startup
* cleanup

##### __[Install]__
`geth` can be installed using both system OS package management systems (e.g `apt-get`, `yum`) and download/extraction from source compressed packages (`.tar`, `.zip`).

The following variables can be customized to control various aspects of this installation process, ranging from software version and the source location of binaries to the installation directory where they are stored.

`install_type: <package | source>` (**default**: source)
- **package**: ONLY supported by Ubuntu and MacOS, package installation of Geth pulls the lastest package available for either platform from the [Ubuntu PPA](https://launchpad.net/~ethereum/+archive/ubuntu/ethereum/+packages) (Personal Package Archive) or the [Mac Homebrew formulae repository](https://formulae.brew.sh/formula/ethereum).
  - Note that the installation directory is determined by the package management system and currently defaults to `/usr/bin/geth` for Linux and `/usr/local/bin/geth` for MacOS. Attempts to set and execute a package installation on other Linux distros will result in failure due to lack of support.
- **source**: compatible with both **tar and zip** formats, source installation binaries can be obtained from local and remote compressed archives either from the official download or releases site or by those generated from development or custom versions of the tool.

`install_src: <path-or-url-to-src>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** package containing `geth` binaries. This method technically supports installation of any available version of `geth`. Links to official versions can be found [here](https://geth.ethereum.org/downloads/).

`install_dir: </path/to/installation/dir>` (**default**: see `defaults/main.yml | vars/main.yml`)
- path on remote host where the `geth` binaries should be extracted to

##### __[Config]__
...

##### __[Startup]__
...

##### __[Cleanup]__
...

Dependencies
------------

None

Example Playbook
----------------

Run a full Ethereum node using "fast" sync-mode, enabling both the RPC server interface and client miner:
```yaml
    - hosts: all
      roles:
      - role: 0xO1.geth
      	vars:
      	  config_dir: /etc/geth
      	  geth_config:
      		Eth:
      		  SyncMode: fast
      		Node:
      		  DataDir: /mnt/geth
      	  extra_run_args: '--rpc  --rpcaddr="0.0.0.0" --config {{ config_dir }}/config.toml --miner.threads 16'
```

License
-------

Apache, BSD, MIT

Author Information
------------------

This role was created in 2019 by O1 Labs.
