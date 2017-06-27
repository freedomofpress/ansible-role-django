django-stack
============

Configurable baseline ansible role for slingin' django code to your server. Many of the
other roles on the internetz were attempting to be all encompassing roles where-as 
I'd like to take advantage of many third-party and internal roles for handling
things like postgres, nginx, etc.

This role is not tied to a specific django repo and its designed to be flexible,
a lot of the flexibility plays out via ansible variables. For local testing and CI
purposes, this repo is being tested against [littleweaverweb.com's repository].

Requirements
------------

These are the following system requirements:

* python2.7+
* virtualenv
* make
* docker

Role Variables
--------------

```
# defaults file for fpf-django-stack
django_stack_app_name: fpf
django_stack_deploy_dir: /var/www/django
django_stack_app_dir: "{{ django_stack_deploy_dir }}"
django_stack_static_root: /var/www/django-static
django_stack_media_root: /var/www/django-media
django_stack_logdir: "/var/log/{{ django_stack_app_name }}"
django_stack_logfile: "django.log"

django_stack_gcorn_home: /home/gcorn
django_stack_gcorn_user: gcorn
django_stack_gcorn_group: gcorn
django_stack_gcorn_port: 8000
django_stack_gcorn_log: "/var/log/{{django_stack_app_name}}/app"
django_stack_gcorn_app: "{{django_stack_app_name}}.wsgi"
django_stack_gcorn_app_settings: "{{django_stack_app_name}}.settings.production"
# if filed out copy this local config to the path defined above
django_stack_override_config: ''
django_stack_gcorn_workers: 8
django_stack_gcorn_threads: 4
django_stack_gcorn_loglevel: info

# virtualenv and pip
django_stack_venv_python: python3
django_stack_venv_sitepackage: no
django_stack_optional_pip: []
# - name: django
#   python: python2

# database settings
django_db_user: django_user
django_db_password: django_password
django_db_host: localhost
django_db_port: 5432

#elasticsearch
django_stack_es_host_url: http://localhost:9200
django_stack_es_ca_path: /etc/ssl/certs/testca_freedom_press.pem

#npm settings
django_stack_npm_install_cmd: npm install
django_stack_npm_dir: "{{ django_stack_app_dir }}"
django_stack_npm_commands: []
django_stack_npm_global_pkgs: []
django_stack_shell_commands: []

django_stack_pkgs:
  - gcc
  - g++
  - python3
  - python3-dev
  - virtualenv
  - libxml2-dev
  - libxslt-dev
  - zlib1g-dev
  - libjpeg-dev
  - libpq-dev
  - libffi-dev

django_stack_git_pkgs:
  - git

# Git code parameters
django_stack_git_repo: []
django_stack_git_deploy: []

# rsync code parameters
django_stack_rsync_pkgs:
  - rsync
django_stack_deploy_src: ""

# django post manage.py tasks
django_stack_db_tasks:
  - migrate
  - collectstatic
django_stack_manage_post: []
django_stack_manage_pre: []

# These will only work if you have a django settings file that
# takes advantage of these environment variables
django_stack_gunicorn_default_envs:
  DJANGO_DB_USER: "{{ django_db_user }}"
  DJANGO_DB_PASSWORD: "{{ django_db_password }}"
  DJANGO_DB_HOST: "{{ django_db_host }}"
  DJANGO_DB_PORT: "{{ django_db_port }}"
  DJANGO_SECRET_KEY: "{{ django_secret_key }}"
  DJANGO_SETTINGS_MODULE: "{{ django_stack_gcorn_app_settings }}"
  DJANGO_STATIC_ROOT: "{{ django_stack_static_root }}"
  DJANGO_MEDIA_ROOT: "{{ django_stack_media_root }}"
  DJANGO_ES_HOST: "{{ django_stack_es_host_url }}"
  DJANGO_ES_CA_PATH: "{{ django_stack_es_ca_path }}"
django_stack_gunicorn_opt_envs: {}

# if set to true, force reinstall of npm and pip packages
# useful for situations were we are disabling the pulling
# of code via git
django_stack_force_refresh: false

django_stack_rsync_opts:
  - "--exclude=.git"
```


Getting started for local deployment
------------------------------------

In order to run a test of the role itself, easiest thing to do is run `make`
which will kick-off a local deployment of the `littleweaverweb` repo against a
docker container.

If you want to experiment with your own site repo, you'll either have to start
folding this role into your deployment playbook and experiment there or start
making local edits to `devops/playbook.yml` accordingly.

Deployment options
------------------
There are two primary otions for deploying your django code-base to the
server in question:

* Utilizing git so that the server will pull the repo's code-base. This requires
  defining parameters in `django_stack_git_repo`. You can optionally also
  deploy a ssh-key that will be utilized to authenticate to a private repo via
  `django_stack_git_deploy`.
* rsync a local copy of the code-base up to the server via `django_stack_deploy_src`.

License
-------

MIT

Author Information
------------------

Michael Sheinberg <mike@freedom.press>

[littleweaverweb.com's repository](https://github.com/littleweaver/littleweaverweb.com)
