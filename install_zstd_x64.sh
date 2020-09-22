#!/bin/bash

set -e

CURL_OPTS="--connect-timeout 60 --retry 5 --retry-delay 20 --fail"
ZSTD_DEB="zstd_1.4.4+dfsg-3_amd64.deb"
LIBZSTD_DEB="libzstd1_1.4.4+dfsg-3_amd64.deb"
LIBZSTD_DEV_DEB="libzstd-dev_1.4.4+dfsg-3_amd64.deb"

function clean_and_exit {
    echo "*** Failed to install, cleaning up..."
    sudo dpkg -r zstd libzstd1 libzstd-dev
    echo "*****"
    echo "Failed to install zstandard packages."
    exit 1
}

for DEB in ${ZSTD_DEB} ${LIBZSTD_DEB} ${LIBZSTD_DEV_DEB}; do
    echo "Installing $DEB ..."

    curl ${CURL_OPTS} \
        --output $DEB \
        https://warriorhq.archiveteam.org/downloads/wget-at/$DEB

    set +e
    sudo dpkg -i $DEB
    EXIT_STATUS=$?
    set -e

    if [ $EXIT_STATUS -ne 0 ]; then
        clean_and_exit
    fi
done

set +e
sudo apt install -f
EXIT_STATUS=$?
set -e

if [ $EXIT_STATUS -ne 0 ]; then
    clean_and_exit
fi
