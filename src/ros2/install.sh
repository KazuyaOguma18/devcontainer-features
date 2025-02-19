#!/bin/sh
set -e           # Exit if any command has non-zero exit code (return non-zero)
set -u           # Referencing undefined variables is an error
set -o pipefail  # Exit if any command in a pipeline fails (return last failed command's code)

# shellcheck source=/dev/null
DISTRO_ID="$(. /etc/os-release && echo "${ID}")"
readonly DISTRO_ID

if [[ "${DISTRO_ID,,}" != "ubuntu" ]]; then
  echo "install.sh: ubuntu distribution required: detected '${DISTRO_ID}'"
  exit 1
fi

echo "Activating feature 'ROS2'"

DISTRO=${DISTRO:-undefined}
echo "The ROS2 distro is: $DISTRO"

# The 'install.sh' entrypoint script is always executed as the root user.

export DEBIAN_FRONTEND=noninteractive

# Set locale
apt-get update && apt-get install --yes --quiet --no-install-recommends locales
locale-gen en_US en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# Add the ROS2 apt-get repository
apt-get install --yes --quiet --no-install-recommends software-properties-common
add-apt-repository universe

# Add the ROS2 GPG key
apt-get update && apt-get install --yes --quiet --no-install-recommends curl
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

# Add the repository to your sources list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install development tools and ROS tools
apt-get update
apt-get install --yes --quiet --no-install-recommends ros-${DISTRO}-${PACKAGE} ros-dev-tools python3-argcomplete

# We should clean up after ourselves
rm -rf /var/lib/apt/lists/*
