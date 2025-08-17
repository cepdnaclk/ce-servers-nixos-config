{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/slurm/client.nix
    ];

  networking = {
    vlans = {
      vlan255 = {
        id = 255;
        interface = "eno1";
      };
    };
    interfaces.vlan255 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "192.248.40.32";
        prefixLength = 26;
      }];
    };
  };

  # Use legacy boot
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  sops.age.keyFile = "/home/ceadmin/.config/sops/age/keys.txt";
}
