#!/bin/bash

set -e

VERSION=2
WARRIOR_FLAG="/tmp/warrior-extras-installer-flag"
VERSION_FILE="/tmp/warrior-extras-installer-version"

if [ ! -f "${WARRIOR_FLAG}" ]; then
    echo "This machine does not appear to be a Warrior. Exiting."
    exit 1
fi

if [ -f "${VERSION_FILE}" ]; then
    INSTALL_VERSION=$(<"${VERSION_FILE}")

    if [ "${VERSION}" = "${INSTALL_VERSION}" ]; then
        echo "===== Done ======"
        echo "= Software is already installed."
        echo "= Select another project."
        exit 0
    fi
fi


echo "Installing Python packages..."

pip3 install --user --upgrade \
    requests \
    zstandard


MACHINE="`uname -m`"
if [ "$MACHINE" = "x86_64" ]; then
    ./install_zstd_x64.sh
    ./install_wget-at_x64.sh
else
    echo "*****"
    echo "* Sorry! wget-at for $MACHINE is not supported yet."
    echo "* The installation for wget-at has been skipped."
    echo "*****"
fi


echo "$VERSION" > "${VERSION_FILE}"

echo "===== Done ======"
echo "= Software succesfully installed!"
echo "= You may now stop this project and select another project."
