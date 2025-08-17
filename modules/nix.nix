{ ... }:
{
  nix.settings = {
    # Enable flakes globally
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # TODO: Move to global location
  system.stateVersion = "24.11";
  
# Remote deploy w/ local build using ceadmin does not work unless
  #nix.settings.trusted-users = [ "ceadmin" ];
}
