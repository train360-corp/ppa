#!/bin/bash

set -e
set -v

cd "$(dirname "$0")"
HERE="$(pwd)"

if [ -z "$KEY" ]; then
  echo "KEY is not set"
  exit 1
fi

# Import the key
echo "$KEY" | gpg --batch --yes --import

export KEYNAME=2708FE95C2F86BA66026C853E47562C3606A0EF4

(
    set -e
    set -v

    cd "$HERE/packages"

    dpkg-scanpackages --multiversion . > Packages
    gzip -k -f Packages

    apt-ftparchive release . > Release

    # Sign with extracted KEYNAME
    gpg --default-key "${KEYNAME}" -abs -o - Release > Release.gpg
    gpg --default-key "${KEYNAME}" --clearsign -o - Release > InRelease
)