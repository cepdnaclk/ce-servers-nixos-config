{
  description = "Entrypoint for ce-server deployments";

  inputs = {
    # TODO: Remove magic number for OS version (24.11)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    defaultModules = import ./modules;
  in 
  {
    # Ada - LDAP Server
    nixosConfigurations.ada = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        defaultModules
        ./hosts/ada
      ];
    };
  };
}
