{
  description = "3D model of the Gerard Bauzil experimental room";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:gepetto/nixpkgs";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;
      perSystem =
        { pkgs, self', ... }:
        {
          packages = {
            default = self'.packages.gerard-bauzil;
            gerard-bauzil = pkgs.callPackage ./. { };
          };
        };
    };
}
