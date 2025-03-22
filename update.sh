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

# Extract the key ID or UID (use the first one found)
export KEYNAME=$(gpg --list-secret-keys --with-colons | awk -F: '$1 == "uid" { print $10; exit }')

# Fallback check
if [ -z "$KEYNAME" ]; then
  echo "Failed to determine KEYNAME from imported key"
  exit 1
fi

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