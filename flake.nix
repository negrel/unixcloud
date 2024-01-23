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
          in
          {
            devShells = {
              default = pkgs.mkShell {
                buildInputs = with pkgs; [
                  # Provides htpasswd.
                  apacheHttpd

                  gnumake
                ];
              };
            };
            packages = pkgs.callPackage ./mediaproc/packages.nix { inherit system pkgs self; } // { };
          });
    in
    outputsWithSystem // outputsWithoutSystem;
}
