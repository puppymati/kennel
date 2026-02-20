{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    opencode.url = "github:anomalyco/opencode/v1.2.10";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };
  outputs =
    inputs@{ self, nixpkgs, ... }:
    {
      nixosConfigurations.mati-nixing = nixpkgs.lib.nixosSystem {
        modules = [
          {
            nixpkgs.overlays = with inputs; [
              nix-cachyos-kernel.overlays.pinned
              opencode.overlays.default
            ];
          }
          ./configuration.nix
        ];
      };
    };
}
