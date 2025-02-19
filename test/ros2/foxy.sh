#!/bin/bash

set -e

source dev-container-features-test-lib

check "ros2 foxy directory found" test -d /opt/ros/foxy

# Report result
reportResults