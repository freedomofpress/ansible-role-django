django-stack
============

Configurable baseline ansible role for slingin' django code to your server. Many of the
other roles on the internetz were attempting to be all encompassing roles where-as 
I'd like to take advantage of many third-party and internal roles for handling
things like postgres, nginx, etc.

Requirements
------------

* vagrant
* ansible

Getting started for local development
-------------------------------------

Take note of the git url code-base you are going to be working on.
Por ejemplo: `git@github.com:littleweaver/littleweaverweb.com.git`

```bash
# the first run you are going to need to run these two commands
# replace DJANGO_GIT_REPO url with your django repo
$ export DJANGO_GIT_REPO=git@github.com:littleweaver/littleweaverweb.com.git
$ ./setup.sh 

$ vagrant up
```

The local folder `app-src/` will be synced to `/var/www/django` in the vm guest
upon first boot. To continually sync updated local work you can:

* do it manually with `vagrant rsync` or
* have vagrant perform it automatically with `vagrant rsync-auto`


Role Variables
--------------

Dependencies
------------

Technically you could rip out these dependencies and just use the base logic for
your django app installation. In that scenario you would need to find replacements
for the following role dependencies:

dependencies:
  - role: jdauphant.nginx
  - role: mikegleasonjr.firewall
  - role: jcalazan.ansible-django-stack
  - role: ANXS.postgresql
  - role: cchurch.ansible-role-django

Example Playbook
----------------

License
-------

MIT

Author Information
------------------

Michael Sheinberg <mike@freedom.press>
