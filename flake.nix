{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        hello-overlay = pkgs.callPackage ./hello.nix { inherit (pkgs) stdenv; };
      in
      {
        packages = { inherit hello-overlay; };
        overlays = {
          default = self: super: {
            hello = super.hello.overrideAttrs (old: {
              version = "0.1.0";
            });
            inherit hello-overlay;
          };
        };
        nixosModules = {
          myModule = import ./module.nix;
        };
      }
    );
}
