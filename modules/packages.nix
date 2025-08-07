{ pkgs, ... }:
{
  # To find packages:
  # $ nix search <package-name>
  environment.systemPackages = with pkgs; [
    # Core
    fastfetch
    vim
    neovim
    git
    htop

    # Archive
    zip
    unzip
    xz

    # Text Processing
    gnugrep # GNU grep, provides `grep`/`egrep`/`fgrep`
    gnused # GNU sed, very powerful(mainly for replacing text in files)
    gawk # GNU awk, a pattern scanning and processing language

    # Networking
    dnsutils
    wget
    curl

    # Misc
    tree
  ];
}
