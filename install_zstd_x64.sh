#!/bin/bash

set -e

CURL_OPTS="--connect-timeout 60 --retry 5 --retry-delay 20 --fail"
ZSTD_DEB="zstd_1.4.4+dfsg-3_amd64.deb"
LIBZSTD_DEB="libzstd1_1.4.4+dfsg-3_amd64.deb"
LIBZSTD_DEV_DEB="libzstd-dev_1.4.4+dfsg-3_amd64.deb"

echo "Fixing any existing apt issues..."
sudo apt install -f -y

echo "Preinstalling old versions..."
sudo apt install -y zstd libzstd1 libzstd-dev

for DEB in ${ZSTD_DEB} ${LIBZSTD_DEB} ${LIBZSTD_DEV_DEB}; do
    echo "Downloading $DEB ..."

    curl ${CURL_OPTS} \
        --output $DEB \
        https://warriorhq.archiveteam.org/downloads/wget-at/$DEB
done

echo "Installing new versions..."

set +e
sudo dpkg -i ${ZSTD_DEB} ${LIBZSTD_DEB} ${LIBZSTD_DEV_DEB}
set -e
sudo apt install -f -y

echo "====="
echo "zstd successfully installed!"
