{ config, pkgs, ... }:
{
  imports = [
      ./hardware-configuration.nix
      ./ldap
      ../../modules/slurm/server.nix
    ];

  # Enable remote deployments only
  services.openssh.settings.PermitRootLogin = "prohibit-password";
  services.openssh.settings.PasswordAuthentication = false;

  # TODO: Move to central location
  sops.age.keyFile = "/home/ceadmin/.config/sops/age/keys.txt";

  networking.hosts = {
    "10.40.18.6" = ["aiken"];
  };

}
