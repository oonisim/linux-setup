Linux setup with Ansible
=========
Setup Linux environment after Linux distribution installation.


#### Module and structure

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

Preparations
------------
### MacOS
To be able to user [realpath](https://stackoverflow.com/questions/3572030/bash-script-absolute-path-with-osx).
```
brew install coreutils
```


#### Ansible
Have Ansible (2.4.1 or later). If the host is RHEL/CentOS/Ubuntu, run below will do the job.

```
(cd ./deployment/ansible/linux/01_prerequisite/scripts && ./setup.sh)
```

SSH server is not installed/enabled by default in some distriutions e.g. Ubuntu.

(cd ./deployment/ansible/linux/01_prerequisite/scripts && ./setup_.sh)



#### SSH
Configure ssh-agent and/or .ssh/config with the AWS SSH PEM to be able to SSH into the targets without providing pass phrase.

```
eval $(ssh-agent)
ssh-add <AWS SSH pem>
ssh ${REMOTE_USER}@<server> sudo ls  # no prompt for asking password

```

Let's try
------------

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
│           └── aws
│               ├── group_vars
│               │   ├── all             <---- Configure properties in the 'all' group vars
│               │   │   ├── server.yml  <---- Server parameters e.g. location of kubelet configuration file
│               │   │   └── env.yaml
│               └── inventory
│                   └── hosts           <---- Target node(s) using tag values (set upon creating AWS env)
```


#### REMOTE_USER
Set the default Linux account (centos for CentOS EC2) that can sudo without password as the Ansible remote_user to run the playbooks If using another account, configure it and make sure it can sudo without password and configure .ssh/config.

#### ENV_ID

Set the inventory name _aws_ to ENV_ID in env.yml which is used to tag the configuration items in AWS (e.g. EC2). The tags are then used to identify configuration items that belong to the enviornment, e.g. EC2 dynamic inventory hosts.


### Execution
In the directory, run run.sh.

```
.
├── deployment
├── maintenance.sh
├── master       <---- Make sure master node information is set in this file
└── run.sh       <---- Run this script
```

Alternatively, run each module one by one, and skip 10_datadog if not using.
```
pushd ansible/linux/<module>/scripts && ./main.sh or
ansible/linux/<module>/scripts/main.sh aws <ansible remote_user>
```

Modules are:
```
├── 01_prerequisite      <---- Module to setup Ansible pre-requisites
├── 02_os                <---- Module to setup OS
├── 03_packages          <---- Module to install packages
├── conductor.sh         <---- Script to conduct playbook executions
└── player.sh            <---- Playbook player
```

