Linux setup with Ansible
=========
Setup Linux environment after Linux distribution installation.

# Module and structure

Module is a set of playbooks and roles to execute a specific task e.g. 03_packages is to install packages with the package manager of the disribution (apt for Ubuntu). Each module directory has the same structure having Readme, Plays, and Scripts.
```
├── 03_packages
│   ├── plays
│   │   ├── roles
│   │   │   ├── site.common
│   │   │   ├── site.java
│   │   │   ├── site.nginx
│   │   │   ├── site.postman
│   │   │   ├── site.psql
│   │   │   ├── gantsign.intellij
│   │   │   ├── williamyeh.nginx
│   │   │   ├── williamyeh.nodejs
│   │   │   └── williamyeh.oracle-java
│   │   └── site.yml
│   ├── Readme.md
│   └── scripts
│       ├── main.sh
│       ├── _posttask.sh
│       ├── _pretask.sh
│       └── _utility.sh
```
---

# Preparations

## Ansible targets

### SSH
#### SSH Server
Run a SSH server and let it accept the public key authentication. May better to disable password authentication once key setup is done.

### Ansible account
Make sure to have an account to run ansible playbooks on the targets. Run the script on the targets which also looks after the authorized_key part.

```aidl
./scripts/ansible/personal/01_prerequisite/scripts/setup_ansible_user.sh
```

#### pip
pip needs to be available for the ansible account to use Ansible pip module.

**Tried to use ansible user local pip but did not work. Hence using system pip.**


<br/>


## Ansible master
### MacOS
To be able to user [realpath](https://stackoverflow.com/questions/3572030/bash-script-absolute-path-with-osx).
```
brew install coreutils
```

### Python
Ansible itself relies on Python. Use Python 3 as Python 2 is end of support.

### pip
Make use of the user site packages instead of system site packages.

Install Ansible relies on pip. See [PyPA pip installation](https://pip.pypa.io/en/stable/installing/).
pip installation is looked after in the 01_prerequisite module setup.sh via get-pip.py.
```
./scripts/ansible/personal/01_prerequisite/scripts/setup.sh
```

### Ansible
Ansible installation is looked after in the 01_prerequisite module setup.sh by calling pip installation.
```
./scripts/ansible/personal/01_prerequisite/scripts/setup.sh
```

#### Vault password
Set the password to decrypt Ansible valut in the file.
```
~/.ansible/.vault_pass.txt
```

#### Auto-login to Ansible targets

```aidl
ssh-copy-id -i ${SSH_PRIVATE_KEY_PATH} ${REMOTE_USER}@${REMOTE_HOST}
```

This will setup ~/.ssh/authorized_keys in the target servers so that the ansible master to be able to ssh into.


### SSH

#### Silent
Configure ssh-agent and/or .ssh/config with the SSH key to be able to SSH into the targets without providing pass phrase.

```
eval $(ssh-agent)
ssh-add <SSH key>
ssh ${REMOTE_USER}@<server> sudo ls  # no prompt for asking password
```


# Run
Run ./run.sh to run all at once or go through the configurations and executions step by step below.

---

Configurations
------------

### Parameters

Parameters for an environment are all isolated in group_vars of the environment inventory. Go through the group_vars files to set values.

```
.
├── conf
│   └── ansible
│      ├── ansible.cfg
│      └── inventories
│           └── ${TARGET}
│               ├── group_vars
│               │   ├── all             <---- Configure properties in the 'all' group vars
│               │   │   ├── server.yml  <---- Server parameters e.g. location of kubelet configuration file
│               │   │   └── env.yaml
│               └── inventory
│                   └── hosts           <---- Target node(s) using tag values (set upon creating env)
```


#### REMOTE_USER
Set the default Linux account (centos for CentOS EC2) that can sudo without password as the Ansible remote_user to run the playbooks If using another account, configure it and make sure it can sudo without password and configure .ssh/config.

#### ENV_ID

Set the ${TARGE} to ENV_ID in env.yml which is used to tag the configuration items in  (e.g. EC2). The tags are then used to identify configuration items that belong to the enviornment.


### Execution
In the directory, run run.sh.

```
.
├── deployment
├── maintenance.sh
└── run.sh       <---- Run this script
```

Alternatively, run each module one by one, and skip 10_datadog if not using.
```
pushd ansible/linux/<module>/scripts && ./main.sh or
ansible/linux/<module>/scripts/main.sh ${TARGET_ENVIRONMENT} ${REMOTE_USER}
```

Modules are:
```
├── 01_prerequisite      <---- Module to setup Ansible pre-requisites
├── 02_os                <---- Module to setup OS
├── 03_packages          <---- Module to install packages
├── conductor.sh         <---- Script to conduct playbook executions
└── player.sh            <---- Playbook player
```

# Post setup

#### PATH
Add "./local/bin" to the PATH environment variable for Python user site packages.

#### Docker
Add those users who run docker commands in **docker** group if required (consider the security risk).