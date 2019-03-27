# needed for rviz to read floating point numbers correctly
export LC_NUMERIC=en_US.UTF-8
export ARDUINO_HOME="/usr/local/apps/arduino-1.8.8"

export RI_ROS_WS=~/development/workspaces/ri-ws
if [[ -f $HOME/development/workspaces/ros/ri-robotics-shell/ri_robotics_shell.sh ]]; then
    . $HOME/development/workspaces/ros/ri-robotics-shell/ri_robotics_shell.sh
    ri_source_ros
    ri_source_devel
fi