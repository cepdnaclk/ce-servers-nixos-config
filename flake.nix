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
      specialArgs = {
        hostname = "ada";
        interface = "enp1s0";
        ip = "10.40.18.12";
      };
      modules = [
        defaultModules
        sops-nix.nixosModules.sops
        ./hosts/ada
      ];
    };

    # Aiken - HPC Server
    nixosConfigurations.aiken = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        hostname = "aiken";
        interface = "eno1";
        ip = "10.40.18.6";
      };
      modules = [
        defaultModules
        sops-nix.nixosModules.sops 
        ./hosts/aiken
      ];
    };
  };
}
