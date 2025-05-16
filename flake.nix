{
  description = "ROS 2 development environment using nix";

  inputs = {
    your-nixos-flake.url = "github:maxkiv/nix";
    nixpkgs.follows = "your-nixos-flake/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    ros2 = {
      url = "github:lopsided98/nix-ros-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    poetry2nix.url = "github:nix-community/poetry2nix";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ros2,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      overlays = [ros2.overlays.default];

      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };

      rosPkgs = pkgs.rosPackages.jazzy;

      poetry2nix = inputs.poetry2nix.lib.mkPoetry2Nix {inherit pkgs;};

      # Use poetry2nix to create a Python environment from pyproject.toml
      pythonEnv = poetry2nix.mkPoetryEnv {
        projectDir = ./.;
        preferWheels = true;
      };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nil
          alejandra

          cmake
          gcc
          pkg-config
          autoreconfHook
          colcon
          boost186
          libxcrypt

          rosPkgs.ament-cmake
          rosPkgs.ament-cmake-core
          rosPkgs.ament-index-python
          rosPkgs.ament-lint
          rosPkgs.ament-package
          rosPkgs.can-msgs
          rosPkgs.diagnostic-updater
          rosPkgs.rclcpp
          rosPkgs.ros-core
          rosPkgs.ros2-control
          rosPkgs.ros2cli
          rosPkgs.ros2launch
          rosPkgs.std-msgs
          rosPkgs.yaml-cpp-vendor
          rosPkgs.canopen-interfaces

          # Python environment with dependencies from pyproject.toml
          pythonEnv
          poetry

          # Basedpyright (Pyright wrapper) for LSP support
          basedpyright

          # python312
          # python312Packages.pyyaml
          # python312Packages.setuptools
          # python312Packages.ament-package
        ];

        # shellHook = ''
        #   export PYTHONPATH=${pkgs.python312Packages.ament-package}/${pkgs.python312.sitePackages}:$PYTHONPATH
        # '';

        # shellHook = ''
        #   export ROS_DOMAIN_ID=42 # avoid collisions
        # '';
      };

      formatter.x86_64-linux = pkgs.alejandra;
    });
  nixConfig = {
    extra-substituters = ["https://ros.cachix.org"];
    extra-trusted-public-keys = ["ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="];
  };
}
