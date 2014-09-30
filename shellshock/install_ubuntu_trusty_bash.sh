#!/bin/bash
set -e

WORKDIR="/tmp"
URL="http://security.ubuntu.com/ubuntu/pool/main/b/bash/bash_4.3-7ubuntu1.4_amd64.deb"
FILENAME="${URL##*/}"

cd "$WORKDIR"
[[ ! -f "$FILENAME" ]] || rm -f "$FILENAME"
trap 'rm -f "$FILENAME"' EXIT

wget -q "$URL"
dpkg -i "$FILENAME"
