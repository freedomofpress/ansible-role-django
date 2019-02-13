django-stack
============

Configurable baseline ansible role for slingin' django code to your server. Many of the
other roles on the internetz were attempting to be all encompassing roles where-as 
I'd like to take advantage of many third-party and internal roles for handling
things like postgres, nginx, etc.

This role is not tied to a specific django repo and its designed to be flexible,
a lot of the flexibility plays out via ansible variables. For local testing
purposes, this repo is being tested against [littleweaverweb.com's repository](https://github.com/littleweaver/littleweaverweb.com).

In order to fully take advantage of the role as currently laid out you'll need
to use nginx and `include snippets/proxy.conf` at any point in your configs
where you'd normally call the `proxy_pass` command, example:

```
location / {
   include snippets/proxy.conf;
}
```

Requirements
------------

These are the following system requirements:

* python2.7+
* virtualenv
* docker

Getting started for local deployment
------------------------------------

In order to run a test of the role itself:

* Install pip requirements in `devops/requirements.txt` (recommend using a
  virtualenv)
* Run `make ci-go`

If you want to experiment with your own site repo, you'll either have to start
folding this role into your deployment playbook and experiment there or start
making local edits to `molecule/ci/playbook.yml` accordingly.

Deployment options
------------------
There are two primary otions for deploying your django code-base to the
server in question:

* Utilizing git so that the server will pull the repo's code-base. This requires
  defining parameters in `django_stack_git_repo`.
* rsync a local copy of the code-base up to the server via `django_stack_deploy_src`.

License
-------

MIT

Author Information
------------------

Michael Sheinberg <mike@freedom.press>
