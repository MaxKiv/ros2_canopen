FROM ros:rolling-ros-core AS base

RUN apt-get update \
    && apt-get install -y \
        python3-rosdep \
        python3-argcomplete \
        python3-colcon-common-extensions \
        build-essential \
        pkg-config \
        python3-wheel

WORKDIR /home/can_ws/src
COPY . ros2_canopen

FROM base AS build

WORKDIR /home/can_ws/
RUN . /opt/ros/rolling/setup.sh \
    && rosdep init && rosdep update \
    && rosdep install --from-paths src --ignore-src -r -y \
    && colcon build \
    && . install/setup.sh
