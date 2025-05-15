# Print all available just commands
help:
    @just --list

build:
    colcon build --symlink-install --merge-install

# Don't work - run in terminal
source:
    . ./install/local_setup.bash

permisssion:
    sudo setcap cap_net_raw,cap_net_admin+eip   ~/git/saxion/ros2_canopen/install/canopen_core/lib/canopen_core/device_container_node

can_up:
    sudo ip link set can0 type can bitrate 250000
    sudo ip link set can0 up

test:
    # TODO similar fix to dryve repo
    ros2 launch canopen_tests dryve.launch.py

gdb:
    gdb --args /home/max/git/saxion/ros2_canopen/install/lib/canopen_core/device_container_node
