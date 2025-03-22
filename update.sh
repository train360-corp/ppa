#!/bin/bash

set -euo pipefail
set -v

cd "$(dirname "$0")"
HERE="$(pwd)"

# Key must be passed via environment variable, e.g., from GitHub Secrets
if [ -z "${KEY:-}" ]; then
  echo "❌ KEY is not set"
  exit 1
fi

# Force usage of this specific key ID
KEY_ID="2708FE95C2F86BA66026C853E47562C3606A0EF4"

# Import the private key (with public portion)
echo "$KEY" | gpg --batch --yes --import

# Trust the key explicitly (level 5 = ultimate)
echo -e "5\ny\n" | gpg --batch --command-fd 0 --edit-key "$KEY_ID" trust

# Confirm key is available
echo "✅ Confirming GPG key is loaded:"
gpg --list-secret-keys --keyid-format LONG "$KEY_ID"

# Go into packages directory
cd "$HERE/packages"

# Generate package index
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

# Generate Release file
apt-ftparchive release . > Release

# Sign the Release file (detached and inline)
gpg -u "$KEY_ID" -abs -o Release.gpg Release
gpg -u "$KEY_ID" --clearsign -o InRelease Release

# Export the public key for APT clients
gpg --export "$KEY_ID" | gpg --dearmor > KEY.gpg

echo "✅ APT repo signed. Verifying signatures..."

# Signature verification
gpg --verify InRelease
gpg --verify Release.gpg Release

echo "✅ Signature verification succeeded for both InRelease and Release.gpg"
