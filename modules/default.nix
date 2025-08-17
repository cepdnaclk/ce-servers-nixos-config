{ ... }:
{
  imports = [  
    ./network.nix
    ./nix.nix
    ./system.nix
    ./packages.nix
    ./ssh.nix
    ./users.nix
  ];
}
