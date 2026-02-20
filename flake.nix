{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    opencode.url = "github:anomalyco/opencode";
    opencode.inputs.nixpkgs.follows = "nixpkgs";

  };
  outputs =
    inputs@{ self, nixpkgs, ... }:
    {
      nixosConfigurations.mati-nixing = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ ./configuration.nix ];
      };
    };
}
