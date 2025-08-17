{ config, ... }:
{
  sops.secrets.munged = {
    reloadUnits = [ "munged.service" ];
    owner = config.systemd.services.munged.serviceConfig.User;
    group = config.systemd.services.munged.serviceConfig.Group;
    mode = "0400";
  };

  systemd.services.munged = {
    serviceConfig.SupplementaryGroups = [ config.users.groups.keys.name ];
  };

  services.munge = {
    enable = true;
    password = config.sops.secrets.munged.path;
  };
}
