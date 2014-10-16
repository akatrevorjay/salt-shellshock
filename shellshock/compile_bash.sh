#!/bin/bash
##
## Manually compile and install bash
## ~ Trevor Joynson (trevorj) <github@skywww.net>
##
set -e

WORKDIR="/usr/src/shellshock"
BASH_FTP_ROOT="http://ftp.gnu.org/gnu/bash"
BASH_VER="4.3"
BASH_PATCH_LEVEL="27"

[[ ! -d "$WORKDIR" ]] || rm -rf "$WORKDIR"
mkdir -p "$WORKDIR"; cd "$WORKDIR"

wget -q "$BASH_FTP_ROOT/bash-${BASH_VER}.tar.gz" -O - | tar zx
cd "bash-$BASH_VER"

# Download patchset
for i in $(seq -f "%03g" 0 $BASH_PATCH_LEVEL); do
    wget -q "$BASH_FTP_ROOT/bash-${BASH_VER}-patches/bash${BASH_VER//.}-$i" -O - \
        | patch -p0 -s
done

# Build and install
./configure && make && make install
