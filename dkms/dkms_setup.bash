#!/bin/bash
#
#  Copyright (c) 2018 Jeong Han Lee
# 
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# Author  : Jeong Han Lee
# email   : jeonghan.lee@gmail.com
# Date    : Sunday, July 29 01:06:29 CEST 2018
# version : 0.0.1


declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_SCRIPTNAME=${0##*/}
declare -gr SC_TOP="${SC_SCRIPT%/*}"

declare -gr SUDO_CMD="sudo";

DKMS_SYSTEMD=dkms.service
SD_UNIT_PATH_DEBIAN=/etc/systemd/system
SD_UNIT_PATH_CENTOS=/usr/lib/systemd/system


function find_dist
{

    local dist_id dist_cn dist_rs PRETTY_NAME
    
    if [[ -f /usr/bin/lsb_release ]] ; then
     	dist_id=$(lsb_release -is)
     	dist_cn=$(lsb_release -cs)
     	dist_rs=$(lsb_release -rs)
     	echo $dist_id ${dist_cn} ${dist_rs}
    else
     	eval $(cat /etc/os-release | grep -E "^(PRETTY_NAME)=")
	echo ${PRETTY_NAME}
    fi

 
}


function setup_dkms_systemd
{
    printf ">>> Setup the systemd %s in %s\n" "${DKMS_SYSTEMD}" "${SD_UNIT_PATH}"
    
    ${SUDO_CMD} install -m 644 ${SC_TOP}/${DKMS_SYSTEMD} ${SD_UNIT_PATH}/
    ${SUDO_CMD} systemctl daemon-reload;
    ${SUDO_CMD} systemctl enable ${DKMS_SYSTEMD};
    ${SUDO_CMD} systemctl start ${DKMS_SYSTEMD};
    printf "\n"
    
}



## Determine CentOS or Debian, because systemd path is different

dist=$(find_dist)

case "$dist" in
    *Debian*)
	SD_UNIT_PATH=${SD_UNIT_PATH_DEBIAN}
	;;
    *CentOS*)
	SD_UNIT_PATH=${SD_UNIT_PATH_CENTOS}
	;;
    *)
	printf "\n";
	printf "Doesn't support the detected $dist\n";
	printf "Please contact jeonghan.lee@gmail.com\n";
	printf "\n";
	exit;
	;;
esac

${SUDO_CMD} -v

# Setup Systemd for the DKMS autoinstall
# dkms.sevice will be started before ethercat.service be started.
setup_dkms_systemd

