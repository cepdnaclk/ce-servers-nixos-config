{ pkgs, ... }: 
{
  users.users.ceadmin = {
    isNormalUser = true;
    description = "ceadmin";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILLicLmiftWyhS/l5KPj8jCdqruh02YqorclJgLvetlB sanka@swift3"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOH/udm3qakyhcEdM39EorrNStL8ky794RZwdZEWNMmE kavishka@kavishkaPC"
    ];
  };
}
