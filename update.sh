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

export KEYNAME="050DDE1853D8E33695C8943CF293341B61731B22"

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