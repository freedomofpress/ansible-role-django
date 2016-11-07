#!/bin/bash


echo "##### Ansible-galaxy dependencies"
ansible-galaxy install -r requirements.yml
if [ -z "$DJANGO_GIT_REPO" ]; then
    echo "##### Local django application code dependency"
    echo "Please set an environment variable named DJANGO_GIT_REPO (in ansible format)"
    echo "(for example: export DJANGO_GIT_REPO=ssh://git@github.com/myorg/mydjango.code.git)"
fi
