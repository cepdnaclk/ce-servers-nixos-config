{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "vmd" "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/e7235486-e1c1-4fe6-9bcd-98c778eb0509";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2DA3-3F65";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/var" =
    { device = "/dev/disk/by-uuid/75a6f0f7-f780-40cd-b87c-0c274bbc5c28";
      fsType = "ext4";
      options = [ "defaults" ];
    };

  swapDevices = [ ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
