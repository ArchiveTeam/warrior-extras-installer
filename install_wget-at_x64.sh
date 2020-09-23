#!/bin/bash

set -e

CURL_OPTS="--connect-timeout 60 --retry 5 --retry-delay 20 --fail"
WGET_DEB="wget-at_1.20.3~warrior0_amd64.deb"
BIN="/opt/wget-at-1.20.3/bin/wget-at"

echo "Install of wget-at will now begin. "

curl ${CURL_OPTS} \
    --output ${WGET_DEB} \
    https://warriorhq.archiveteam.org/downloads/wget-at/${WGET_DEB}

set +e
sudo dpkg -i ${WGET_DEB}
sudo apt install --fix-missing -y
set -e
sudo apt install --fix-broken -y

echo "wget-at build ok"
echo "Binary path: $BIN"
$BIN --help | grep -iE "gnu|warc|lua"
echo "====="
echo "wget-at built and installed sucessfully!"
echo "====="
