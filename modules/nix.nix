{ ... }:
{
  nix.settings = {
    # Enable flakes globally
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
