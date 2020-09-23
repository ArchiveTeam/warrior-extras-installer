# warrior-extras-installer

Pseudo-project for installing project dependencies in the Warrior VM appliance

This [pipeline](https://github.com/archiveteam/seesaw-kit) is intended to be run within a [Warrior VM appliance](https://github.com/archiveteam/ubuntu-warrior) or within a [Warrior docker container](https://github.com/archiveteam/warrior-dockerfile).

The following will be directly installed:

* Python requests
* Python zstandard

x86_64 only:

* libzstd debian packages 1.4.4
* [wget-at](https://github.com/archiveteam/wget-lua)

For issues relating to the *installation process* of these packages in the Warrior appliance or container, please file them in this repository. Otherwise, please file them in the appropriate repositories!

## Dev

wget-at is built using the GitHub workflow file, but only for x86_64 on Ubuntu 18.04 currently.

If you can get builds working for Raspberry Pi, please feel free to put a pull request or issue.
