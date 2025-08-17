{ lib, inputs, ... }:
{
  sops.defaultSopsFile = ../secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  # Bootloader.
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  time.timeZone = "Asia/Colombo";
  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo.wheelNeedsPassword = false;


}
