# Build and deploy this NixOS derivation
deploy:
    sudo nixos-rebuild switch --flake .

permisssion:
    sudo setcap cap_net_raw+ep   ~/git/saxion/ros2_canopen/install/canopen_core/lib/canopen_core/device_container_node

can_up:
    sudo ip link set can0 type can bitrate 250000
    sudo ip link set can0 up
