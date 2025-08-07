{
  description = "Entrypoint for ce-server deployments";

  inputs = {
    # TODO: Remove magic number for OS version (24.11)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, sops-nix, ... }@inputs: 
  let
    defaultModules = import ./modules;
  in 
  {
    # Ada - LDAP Server
    nixosConfigurations.ada = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        defaultModules
        # sops-nix.nixosModules.sops
        ./hosts/ada
      ];
    };
  };
}
