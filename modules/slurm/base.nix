# https://mynixos.com/nixpkgs/options/services.slurm 
# https://discourse.nixos.org/t/advice-for-simple-nixos-setup-of-local-slurm-cluster-for-home/1995/4
# https://github.com/CRTified/nix-cluster/tree/main
{ interface, ... }:
{
  imports = [
    ./munged.nix
  ];

  networking.firewall.interfaces."${interface}" = {
    allowedTCPPortRanges = [{
      from = 60001;
      to = 63000;
    }];
  };

  services.slurm = {
    clusterName = "ce-cluster";
    controlMachine = "ada";
    controlAddr = "10.40.18.12";

    nodeName = [
      #"10.40.18.6"
      "aiken"
    ];

    partitionName = [
      #"debug Nodes=10.40.18.6 Default=YES MaxTime=INFINITE State=UP"
      "debug Nodes=aiken Default=YES MaxTime=INFINITE State=UP"
    ];

    extraConfig = ''
      AccountingStorageHost=ada
      AccountingStorageType=accounting_storage/slurmdbd

      TCPTimeout=5

      SrunPortRange=60001-63000
      ResumeTimeout=600

    '';
  };
}
