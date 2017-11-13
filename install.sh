#!/usr/bin/env bash

# Copyright 2017 Rafal Zajac <rzajac@gmail.com>.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

# ESP8266 library installation script.
#
# Installer expects that:
# - The ESPROOT environment variable set.
# - The esp-open-sdk is installed and compiled at ESPROOT/esp-open-sdk.

# The full GitHub URL to the library.
LIB_FULL_NAME="rzajac/esp-cmd"

# No modifications below this comment unless you know what you're doing.

TMP_DIR=`mktemp -d`
LIB_REPO="https://github.com/${LIB_FULL_NAME}"
LIB_NAME=${LIB_FULL_NAME##*/}
CMAKE=`which cmake`

# Remove temporary directory.
function rm_tmp() {
    echo "Removing ${TMP_DIR}"
    rm -rf ${TMP_DIR}
}

# Check / set ESPROOT.
if [ "${ESPROOT}" == "" ]; then ESPROOT=$HOME/esproot; fi
if ! [ -d "${ESPROOT}" ]; then mkdir -p ${ESPROOT}; fi
echo "Using ${ESPROOT} as ESPROOT"

echo "Cloning ${LIB_REPO} to temporary directory ${TMP_DIR}."
git clone ${LIB_REPO} ${TMP_DIR}
if [ $? != 0 ]; then
    echo "Error: Cloning ${LIB_REPO} failed!"
    rm_tmp
    exit 1
fi

echo "Installing library ${LIB_NAME} to ${ESPROOT}"
mkdir ${TMP_DIR}/auto-build
(cd ${TMP_DIR}/auto-build && ${CMAKE} .. && make install)
if [ $? != 0 ]; then
    echo "Error: Installing library ${LIB_NAME} failed!"
    rm_tmp
    exit 1
fi

rm_tmp

exit 0
