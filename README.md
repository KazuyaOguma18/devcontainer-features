# Dev Container Features

This repository contains a Feature - `ROS 2`.

## `ROS 2`

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/KazuyaOguma18/devcontainer-features/ros2:latest": {
            "distro": "jazzy" // "foxy" or "humble"
        }
    }
}
```

## License

This package is licensed under the MIT license.

It used the template [devcontainers feature starter](https://github.com/devcontainers/feature-starter) as a starting template.

It uses installation instructions from [ROS2](https://docs.ros.org/en/jazzy/Installation.html)