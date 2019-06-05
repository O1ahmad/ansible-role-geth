Geth Ansible Role
=========

Ansible role that installs, configures and runs as a service, Geth: a command-line interface for running an ethereum node :star2: :link: :bulb:

### Supported Platforms:
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

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:
```yaml
    - hosts: servers
      roles:
      - role: 0xO1.geth
      	vars:
      	  install_type: source
      	  install_src: https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.8.27-4bcc0a37.tar.gz
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
