#!/bin/bash

set -e

CURL_OPTS="--connect-timeout 60 --retry 5 --retry-delay 20 --fail"
WGET_DEB="wget-at-1.20.3~warrior0_amd64.deb"
BIN="/opt/wget-at-1.20.3/wget-at"

echo "Install of wget-at will now begin. "

curl ${CURL_OPTS} \
    --output ${WGET_DEB} \
    https://warriorhq.archiveteam.org/downloads/wget-at/${WGET_DEB}

set +e
sudo dpkg -i ${WGET_DEB}
EXIT_STATUS=$?
set -e

if [ $EXIT_STATUS -ne 0 ]; then
    echo "Failed to install package, cleaning up..."
    sudo dpkg -r wget-at
    echo "*****"
    echo "wget-at failed to install!"
    exit 1
fi

sudo apt install -f

echo "====="
echo "AchiveTeam's wget built and installed sucessfully."
echo "Advanced info:"
echo "Binary path: $BIN"
$BIN --help | grep -iE "gnu|warc|lua"
echo "====="
