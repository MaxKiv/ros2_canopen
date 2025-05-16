# Print all available just commands
help:
    @just --list

build:
    CMAKE_EXPORT_COMPILE_COMMANDS=ON && colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug --symlink-install --merge-install && ln -sf . /build/compile_commands.json compile_commands.json

# Doesn't work - run in terminal
source:
    . ./install/local_setup.bash

permisssion:
    sudo setcap cap_net_raw,cap_net_admin+eip   ~/git/saxion/ros2_canopen/install/canopen_core/lib/canopen_core/device_container_node

can_up:
    sudo ip link set can0 txqueuelen 1000
    sudo ip link set can0 up type can bitrate 250000

test:
    # TODO similar fix to dryve repo
    ros2 launch canopen_tests dryve.launch.py

gdb:
    gdb --args /home/max/git/saxion/ros2_canopen/install/lib/canopen_core/device_container_node --ros-args -r __node:=device_container_node -r __ns:=/ --params-file /tmp/launch_params_euzbqgim --params-file /tmp/launch_params_yac_l1hm --params-file /tmp/launch_params_9hapgap7 --params-file /tmp/launch_params_jbjmm2g6
