#!/bin/bash

if [ $# -eq 0 ]; then
    echo "usage: $0 <interface>"
    exit
fi
INTERFACE=$1
# spdp is important to avoid slowing down WiFi to 6Mbps (by avoiding multicast)
# for details, check CYCLONE DDS doc (https://github.com/eclipse-cyclonedds/cyclonedds/blob/master/docs/manual/options.md)
CYCLONEDDS_URI="<CycloneDDS><Domain><General><AllowMulticast>spdp</AllowMulticast><NetworkInterfaceAddress>$INTERFACE</NetworkInterfaceAddress></General></Domain></CycloneDDS>"

docker create -t --name ros2_wheeltec_robot -e CYCLONEDDS_URI=$CYCLONEDDS_URI --network host --ipc host --privileged --shm-size 8G -v /dev:/dev ros2_wheeltec_robot bash
