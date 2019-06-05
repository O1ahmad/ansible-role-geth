Geth Ansible Role
=========

Ansible role that installs, configures and runs as a service, Geth: a command-line interface for running an ethereum node :star2: :link: :bulb:

##### Supported Platforms:
```
* CentOS/RHEL
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

###### [INSTALL]
Installation via both system OS package management systems and download/extraction from source compressed packages (`.tar`, `.zip`) is supported.

###### [CONFIG]
...

###### [STARTUP]
...

###### [CLEANUP]
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
