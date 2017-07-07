#!/bin/bash
#
#

set -e

curdir="$(dirname $(realpath "$0") )"

# Ensure virtualenv activated and ansible roles installed
"${curdir}/env-startup"
source "${curdir}/../.venv/bin/activate"

echo "##### Run Tests"
testinfra --connection=docker --hosts=django_stack_prod ${curdir}/../tests/
