#!/bin/bash
source $SRC/lib/functions.sh

TEST_TITLE="Update"
TEST_SKIP="true"
[[ $DRY_RUN == true ]] && return 0

display_alert "$(basename $BASH_SOURCE)" "$(date  +%R:%S)" "info"

remote_exec "LANG=C apt-get -o Dpkg::Options::=\"--force-confold\" -qq -y update &>/dev/null"
PACKAGES=$(remote_exec "DEBIAN_FRONTEND=noninteractive LANG=C apt-get upgrade -s |grep -P '^\d+ upgraded'|cut -d\" \" -f1")
display_alert "Updating and upgrading" "${PACKAGES} packages" "info"
remote_exec "DEBIAN_FRONTEND=noninteractive LANG=C apt-get -y upgrade &>/dev/null"
