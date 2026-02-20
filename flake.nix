{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    opencode.url = "github:anomalyco/opencode/v1.2.10";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    nixcord.url = "github:FlameFlag/nixcord";
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
            ];

            imports = [ inputs.nixcord.nixosModules.nixcord ];
          }
          ./configuration.nix
        ];
      };
    };
}
