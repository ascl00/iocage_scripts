#!/usr/bin/env bash

set -e 
# This script assumes you have activated iocage pointing at $JAIL_POOL
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Check we are effectively running as root
if [ `id -u` -ne 0 ]; then
    echo "Need to be running as root, not `id -u -nr`"
    exit
fi

# sanity check, can we find a config?
if [ ! -e $DIR/config.sh ]; then
    echo "Failed to find $DIR/config.sh, cannot proceed"
    exit
fi

# Pull in the configuration
. $DIR/config.sh

# Pull in the various jail configs
jail_configs=`ls -1 $JAIL_CONFIGS`

# Grab the required release if we don't have it
if iocage list -r |  egrep -v '(=|\+|Bases)' | grep -v -q $RELEASE ; then
    iocage fetch -r $RELEASE
fi

# See which jails we already have installed
installed_apps=`iocage list -h -q | cut -f1 `
for app in $jail_configs; do
    is_app_installed=`echo $installed_apps | grep -qw $app && echo 1 || echo 0`
    if [ $is_app_installed -eq 0 ]; then
        . $JAIL_CONFIGS/${app}
        setup_${app}
    else
        echo $app already installed, skipping...
    fi
done

echo "All done!"


