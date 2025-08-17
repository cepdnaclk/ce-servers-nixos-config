{ pkgs, interface, ... }:
{
  imports = [
    ./base.nix
  ];

  networking.firewall.interfaces."${interface}".allowedTCPPorts =
    [ 6818 ];

  services.slurm = { client = { enable = true; }; };
}
