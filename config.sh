#!/usr/bin/env bash

set -e

# Set up appropriate variables
# Note, cant be newer than FreeNAS version
RELEASE=11.2-RELEASE
# You will need to change this
GATEWAY=192.168.20.1
# and this
DNS='nameserver 192.168.20.1'
NETWORKING_OPTIONS="dhcp=on vnet=on bpf=yes defaultrouter=$GATEWAY resolver=$DNS allow_raw_sockets=1"

# This is the uid of the user to create in the jails
# Important this is consistent across jails that read or write
# files used by other jails
JAIL_USER_ID=1003

# And most likely these
JAIL_POOL=/mnt/Jails
JAIL_CONFIG=$JAIL_POOL/apps
_iocage_zpool=`iocage get -p`
IOCAGE_JAILS=/mnt/${_iocage_zpool}/iocage/jails


# Destination for downloads, and source of post processing
# Needed for sonarr, nzbget, beets
DOWNLOAD_POOL=/mnt/Jails/Downloads
# Sonarr needs this
TV_DIR=/mnt/Tank/Multimedia/Video/TV
# Beets needs this
MUSIC_DIR=/mnt/Tank/Multimedia/Music
# For Plex Media Server
VIDEO_DIR=/mnt/Tank/Multimedia/Video
PHOTO_DIR=/mnt/Tank/Multimedia/Photos

# don't change these
JAIL_FILES=$DIR/jail_files
JAIL_CONFIGS=$DIR/jail_configs
