#!/bin/bash


echo "##### Ansible-galaxy dependencies"
ansible-galaxy install -r requirements.yml
echo "##### Local django application code dependency"
if [ ! -d ./app-src ]; then
    if [ -z "$DJANGO_GIT_REPO" ]; then
        echo -n "Enter the git repo url for the django code : "
        read DJANGO_GIT_REPO
    fi
    git clone $DJANGO_GIT_REPO app-src
else
    echo "Custom django repo already checked out at under app-src/"
fi
