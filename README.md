django-stack
============

Configurable baseline ansible role for slingin' django code to your server. Many of the
other roles on the internetz were attempting to be all encompassing roles where-as 
I'd like to take advantage of many third-party and internal roles for handling
things like postgres, nginx, etc.

This role is not tied to a specific django repo, so you'll have to specify
 via environment or ansible variable.

Requirements
------------

These are the following system requirements:

* vagrant
* ansible >= 2.2.x

Getting started for local development
-------------------------------------

Take note of the git url code-base you are going to be working from.
Here is an example of a public django repo made by our friends at
littleweaver: `git@github.com:littleweaver/littleweaverweb.com.git`.


```bash
# the first run you are going to need to run these two commands
# replace DJANGO_GIT_REPO url with your django repo
$ export DJANGO_GIT_REPO=git@github.com:littleweaver/littleweaverweb.com.git
$ ./setup.sh 

$ vagrant up
```

What happened here ^^^?
* Ansible galaxy dependencies were pulled into `roles/`
* The git repo you specified was pulled down into `app-src/`
* `app-src/` was rsynced over to the vagrant box
* the vagrant box is fired up and local `playbook.yml` is run

Should then be able to fire up a web-browser and hit:
`http://localhost:8080/`

The local folder `app-src/` will be synced to `/var/www/django` in the vm guest
upon first boot. To continually sync updated local work you can:

* do it manually with `vagrant rsync` or
* have vagrant perform it automatically with `vagrant rsync-auto`

Note this is slightly different than how you deploy this role in production. Added
some shortcuts for ease of use to suit local app development.

Dependencies
------------

For local development dependencies are located in `requirements.yml` and
installed when running the `setup.sh` script.

When utilized as a role, as part of a larger ansible environment, these dependencies are *not*
defined in the meta folder. This was intentional design. Soo you would
have to go through and manually integrate your own dependencies or copy the
`requirements.yml` and install to your global roles path. It is recommended you
utilize the `playbook.yml` located at the root of this repo as a reference.

The other difference between the local dev and prod is that here I use a cheat
to utilize a developers existing creds to pull down the git code and rsync it,
in prod deployment you need to have access to git deploy keys if it is a private
repo. Those keys will get distributed to the end-system and the git repo pulled
in, assuming you specified a git repo in the role variables. `tasks/pull_sitecode.yml`
handles this legwork which you can optionally skip (means you would have to
lay out the django code in some other way). By default you can drop a deploy key
at `./deploy_key` which will be copied over and can be used for git checkout.


Example Playbook
----------------
Check out `./playbook.yml` when using this role in deployment. This is the
playbook that the vagrant provisioning and molecule testing will run off.

License
-------

MIT

Author Information
------------------

Michael Sheinberg <mike@freedom.press>
