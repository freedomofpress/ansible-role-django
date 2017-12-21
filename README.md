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

Role Variables
--------------

```yaml
# defaults file for fpf-django-stack
django_stack_app_name: fpf
django_stack_deploy_dir: /var/www/django
django_stack_app_dir: "{{ django_stack_deploy_dir }}"
django_stack_static_root: /var/www/django-static
django_stack_media_root: /var/www/django-media
django_stack_logdir: "/var/log/{{ django_stack_app_name }}"
django_stack_logfile: "django.log"
django_stack_gcorn_home: /home/gcorn
django_stack_active_svc_file: "{{ django_stack_gcorn_home }}/active_gunicorn_svc"

django_stack_gcorn_user: gcorn
django_stack_gcorn_group: gcorn
# Two gunicorn services will be stood up over multiple runs
# Nginx will alternate to forwarding to either one during upgrades to reduce
# upgrade side-effects on a live server
django_stack_gcorn_ports:
  alpha: 8000
  beta: 8001
django_stack_active_gcorn_svc: "{{ django_stack_gcorn_ports.keys()[0] }}"
django_stack_gcorn_log: "/var/log/{{django_stack_app_name}}/app"
django_stack_gcorn_app: "{{django_stack_app_name}}.wsgi"
django_stack_gcorn_app_settings: "{{django_stack_app_name}}.settings.production"
# if filed out copy this local config to the path defined above
django_stack_override_config: ''
django_stack_gcorn_workers: 8
django_stack_gcorn_threads: 4
django_stack_gcorn_loglevel: info

# If you want to try to keep output to a minimum, toggle this on.
# For example, in CI verbose built output can obscure relevant test info.
django_stack_global_no_log: no

# virtualenv and pip
django_stack_venv_env_file: "{{ django_stack_gcorn_home }}/.gunicorn-env"
django_stack_venv_python: python3
django_stack_venv_sitepackage: no
django_stack_venv_no_log: "{{ django_stack_global_no_log }}"
django_stack_venv_base_pkgs: []
django_stack_venv_cmds: []
django_stack_venv_docker_volumes: []
django_stack_venv_docker_image: "quay.io/freedomofpress/ci-webserver:latest"
django_stack_optional_pip: []
# - name: django
#   python: python2
# Optional dictionary to pass to virtualenv docker builder
django_stack_venv_env: {}

# database settings
django_db_user: django_user
django_db_password: django_password
django_db_host: localhost
django_db_port: 5432

# elasticsearch
django_stack_es_host_url: http://localhost:9200
django_stack_es_ca_path: /etc/ssl/certs/testca_freedom_press.pem

# npm settings
django_stack_npm_install_cmd: "npm install; npm run start"
django_stack_npm_dir: "{{ django_stack_app_dir }}"
django_stack_npm_no_log: "{{ django_stack_global_no_log }}"
django_stack_npm_global_pkgs: []
django_stack_shell_commands: []
# This is the tag for the node image used locally to prepare the code
django_stack_node_ver: 6.11.0-alpine

# Default to a slim node Dockerfile shipped with role, but permit overrides.
django_stack_node_dockerfile: "{{ role_path }}/docker/NodeDockerfile"
django_stack_node_dockercontext: "{{ role_path }}/docker"

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
django_stack_rsync_no_log: "{{ django_stack_global_no_log }}"
django_stack_deploy_src: ""

# django post manage.py tasks
django_stack_db_tasks:
  - migrate
  - collectstatic
django_stack_manage_post: []
django_stack_manage_post_ignore: yes
django_stack_manage_pre: []
django_stack_manage_no_log: "{{ django_stack_global_no_log }}"

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

django_stack_rsync_opts: []

django_stack_www_snippets:
  - path: /etc/nginx/snippets/proxy.conf
    template: nginx-snippet.j2
    notify: reload nginx

# Over-ride this boolean to enable celery worker system service
django_stack_celery_worker: false
django_stack_celery_nodes: "w1"
django_stack_celery_user: "{{ django_stack_gcorn_user }}"
django_stack_celery_group: "{{ django_stack_gcorn_group }}"
django_stack_celery_svc_name: "celery-www"
django_stack_celery_svc_conf:
  pid_file: "/var/run/celery/%n.pid"
  log_file: "/var/log/celery/%n%I.log"
  log_level: INFO
  opts: "--time-limit=300 --concurrency=8"
  nodes: "{{ django_stack_celery_nodes }}"
  user: "{{ django_stack_celery_user }}"
  group: "{{ django_stack_celery_group }}"
django_stack_celery_sysd:
  after: network.target
```


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
