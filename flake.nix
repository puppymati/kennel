{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-compat = {
      url = "github:NixOS/flake-compat";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-parts.follows = "flake-parts";
    };

    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
      inputs.flake-parts.follows = "flake-parts";
    };

    opencode = {
      url = "github:anomalyco/opencode/v1.2.10";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{ self, nixpkgs, ... }:
    {
      nixosConfigurations.mati-nixing = nixpkgs.lib.nixosSystem {
        modules = with inputs; [
          {
            nixpkgs.overlays = [
              nix-cachyos-kernel.overlays.pinned
              opencode.overlays.default

              (final: prev: {
                zen-browser = inputs.zen-browser.packages.${prev.system}.default;
              })
            ];

            imports = [ inputs.nixcord.nixosModules.nixcord ];
          }
          ./configuration.nix
        ];
      };
    };
}
