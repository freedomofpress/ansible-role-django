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

Should then be able to fire up a web-browser and hit:
`http://http://localhost:8080/`

The local folder `app-src/` will be synced to `/var/www/django` in the vm guest
upon first boot. To continually sync updated local work you can:

* do it manually with `vagrant rsync` or
* have vagrant perform it automatically with `vagrant rsync-auto`


Role Variables
--------------

Dependencies
------------

For local development dependencies are located in `requirements.yml` and
installed when running the `setup.sh` script. When utilized as a role as part of
a larger ansible installation, these dependencies are not called and have to be
separated defined and brought in on whatever playbook is used. Recommend you
utilize the `playbook.yml` located at the root of this repo as a reference.

Example Playbook
----------------
`./playbook.yml`

License
-------

MIT

Author Information
------------------

Michael Sheinberg <mike@freedom.press>
