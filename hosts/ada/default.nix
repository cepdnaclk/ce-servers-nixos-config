{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./ldap
      (import ../../modules/network.nix {
        hostname = "ada";
        interface = "enp1s0";
        ip = "10.40.18.12";
      })
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable remote deployments only
  services.openssh.permitRootLogin = "prohibit-password";
  services.openssh.passwordAuthentication = false;

  # TODO: Move to global location
  system.stateVersion = "24.11";
}
