FROM tiryoh/ros2-desktop-vnc:humble

WORKDIR /home/ubuntu/ros_ws

# Install additional packages
RUN apt-get update && apt-get install -y \
    && apt-get install -y --no-install-recommends \
    ros-humble-gazebo-* \
    ros-humble-joint-state-publisher-gui \
    ros-humble-rqt-robot-steering

# Create workspace and Colcon build
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
                  mkdir -p /home/ubuntu/ros_ws/src"

# Build the workspace again
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
                  cd /home/ubuntu/ros_ws && \
                  colcon build --symlink-install"
# Clone Limo repo
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
                  cd /home/ubuntu/ros_ws/src && \
                  git clone https://github.com/Los-UruBots-del-Norte/limo_ros2.git -b humble && \
                  mkdir -p /home/ubuntu/ros_ws/src/limo_ros2/limo_car/log && \
                  mkdir -p /home/ubuntu/ros_ws/src/limo_ros2/limo_car/src && \
                  mkdir -p /home/ubuntu/ros_ws/src/limo_ros2/limo_car/worlds && \
                  cd /home/ubuntu/ros_ws/ && \
                  colcon build --symlink-install"

# Set up the workspace
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
                  echo 'source /home/ubuntu/ros_ws/install/setup.bash' >> ~/.bashrc"

