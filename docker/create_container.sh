if [ $# -eq 0 ]; then
    echo "usage: $0 <image_name> <interface>"
    exit
fi
IMAGE_NAME=$1
INTERFACE=$2
# spdp is important to avoid slowing down WiFi to 6Mbps (by avoiding multicast)
# check CYCLONE DDS doc for detail
CYCLONEDDS_URI="<CycloneDDS><Domain><General><AllowMulticast>spdp</AllowMulticast><NetworkInterfaceAddress>$INTERFACE</NetworkInterfaceAddress></General></Domain></CycloneDDS>"

docker create -t --name ros2_wheeltec_robot -e CYCLONEDDS_URI=$CYCLONEDDS_URI --network host --ipc host --privileged --shm-size 8G -v /dev:/dev $IMAGE_NAME bash
