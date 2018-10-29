Role Name
=========

Setup PostgreSQL for APP.

Requirements
------------


Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

- APP_USER    : Application database owner
- APP_RDB_NAME: Application database name
- APP_RDB_PASS: Database password

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: site.host }

License
-------

Copyright © 2017 KPMG Capital Limited and KPMG Capital Holding Limited.
All rights reserved.

Author Information
------------------

KPMG Capital Limited and KPMG Capital Holding Limited.
