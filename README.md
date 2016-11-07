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
* molecule

Easy way to install the last two is to utilize a virtualenv and install with:

```bash
$ pip install -r requirements.txt
```

Getting started for local deployment
------------------------------------

Take note of the git url code-base you are going to be working from.
This has to be in [ansible git repo](https://docs.ansible.com/ansible/git_module.html).

An example is: `ssh://git@github.com/myorg/mysite.com.git`. If you are using a
publically visible git repo, you should set the following in your playbook:

```yaml
django_stack_git_deploy: []
```

Once you got that sorted out, from a terminal sitting in this directory:

```bash
# the first run you are going to need to run these two commands
# replace DJANGO_GIT_REPO url with your django repo
$ export DJANGO_GIT_REPO=ssh://git@github.com/myorg/mysite.com.git
$ ./setup.sh 

# copy a read-only deploy key to ./deploy_key if applicable
$ cp ~/.ssh/github_deploy ./deploy_key
$ molecule converge
```

What happened here ^^^?
* Ansible galaxy dependencies were pulled into `roles/`
* the vagrant box is fired up and local `playbook.yml` is run

Should then be able to fire up a web-browser and hit:
`http://localhost:8080/`


Dependencies
------------

For local development dependencies are located in `requirements.yml` and
installed when running the `setup.sh` script.

When utilized as a role, as part of a larger ansible environment, these dependencies are *not*
defined in the meta folder. This was intentional design. Soo you would
have to go through and manually integrate your own dependencies or copy the
`requirements.yml` and install to your global roles path. It is recommended you
utilize the `playbook.yml` located at the root of this repo as a reference.

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
