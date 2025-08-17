# Remote Deployment

## - Prerequisites
- nix package manager : https://nixos.org/download/
- Make sure flakes are enabled. Add the following to ``~/.config/nix/nix.conf`` or ``/etc/nix/nix.conf``: 
```
experimental-features = nix-command flakes
```

Configurations can be deployed remotely to the servers using following command

```
nix shell nixpkgs#nixos-rebuild -c nixos-rebuild switch --flake .#<server-name> --target-host <user@server-ip> --build-host <server-name> --use-remote-sudo
```

# Creating Munged Key
dd if=/dev/urandom bs=1 count=1024 | base64 -w0
