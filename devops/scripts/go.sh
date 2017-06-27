#!/bin/bash
#
#

set -e

curdir="$(dirname $(realpath "$0") )"
source "${curdir}/../.docker_versions"

# Ensure virtualenv activated and ansible roles installed
"${curdir}/env-startup"
source "${curdir}/../.venv/bin/activate"

# Ensure we are in the devops directory
cd "$(dirname $(dirname $(realpath $0) )../)"|| exit

echo "##### Pull Docker Image"
docker pull "${CIWWW_IMAGE}@sha256:${CIWWW_VER}" &> /dev/null
# molecule needs a tag to import
docker tag "${CIWWW_IMAGE}@sha256:${CIWWW_VER}" "${CIWWW_IMAGE}:latest"
echo "##### Run Django provision"
if [ "$1" != "only_tests" ]; then
    molecule create
    molecule converge
fi
