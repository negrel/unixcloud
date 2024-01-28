{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    let
      outputsWithoutSystem = { };
      outputsWithSystem = flake-utils.lib.eachDefaultSystem
        (system:
          let
            pkgs = import nixpkgs {
              inherit system;
            };
            lib = pkgs.lib;
            mediaprocInputs = with pkgs; [
              bash
              gnumake
              coreutils
              findutils
              inotify-tools
              file
              exiftool
              vips
            ];
          in
          {
            devShells = {
              default = pkgs.mkShell {
                buildInputs = with pkgs; [
                  gnumake

                  # httpd/
                  apacheHttpd

                  # web/
                  nodejs

                  # tests/
                  bats
                ] ++ mediaprocInputs;
              };
            };
            packages = pkgs.callPackage ./mediaproc/packages.nix
              {
                inherit system pkgs self lib;
                runtimeInputs = mediaprocInputs;
              } // { };
          });
    in
    outputsWithSystem // outputsWithoutSystem;
}
