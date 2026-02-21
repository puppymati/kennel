{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    opencode.url = "github:anomalyco/opencode/v1.2.10";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    nixcord.url = "github:FlameFlag/nixcord";
    zen-browser.url = "github:youwen5/zen-browser-flake";
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
