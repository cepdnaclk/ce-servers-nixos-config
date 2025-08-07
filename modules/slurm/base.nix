# https://mynixos.com/nixpkgs/options/services.slurm 
# https://discourse.nixos.org/t/advice-for-simple-nixos-setup-of-local-slurm-cluster-for-home/1995/4
# https://github.com/CRTified/nix-cluster/tree/main
{ interface }:
{ lib, ... }:
{

  # Optional: expose slurm ports in firewall
  # networking.firewall.allowedTCPPorts = [ 6817 6818 ];
  networking.firewall.interfaces."${interface}" = {
    allowedTCPPortRanges = [{
      from = 60001;
      to = 63000;
    }];
  };

  services.slurm = {
    clusterName = "ce-cluster";
    controlMachine = "ada";
    controlAddr = "ada-link";

    nodeName = [
      "aiken"
    ];

    partitionName = [
      "debug Nodes=aiken Default=YES MaxTime=INFINITE State=UP"
    ];

    extraConfig = ''
      AccountingStorageHost=ada-link
      AccountingStorageType=accounting_storage/slurmdbd

      TCPTimeout=5

      SrunPortRange=60001-63000
      ResumeTimeout=600

    '';
  };
}
