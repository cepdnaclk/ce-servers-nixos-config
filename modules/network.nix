{ hostname, interface, ip, ... }:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    wireless.enable = false;

    interfaces."${interface}" = {
      useDHCP = false;
      ipv4.addresses = [{
        address = ip;
        prefixLength = 24;
      }];
    };

    defaultGateway = {
      address = "10.40.18.254";
      interface = interface;
    };

    nameservers = [
      "10.40.2.1"
      "8.8.8.8"
    ];

    firewall = {
      enable = true;
    };
  };
}
