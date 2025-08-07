{ pkgs, ... }:
{
  # ==================== TODO: Remove ====================
  networking.firewall.interfaces."enp1s0" = {
    allowedTCPPortRanges = [{
      from = 60001;
      to = 63000;
    }];
  };

  services.slurm = {
    clusterName = "ce-cluster";
    controlMachine = "ada";
    controlAddr = "ada-link";

    nodeName = [
      "aiken"
    ];

    partitionName = [
      "debug Nodes=aiken Default=YES MaxTime=INFINITE State=UP"
    ];

    extraConfig = ''
      AccountingStorageHost=ada
      AccountingStorageType=accounting_storage/slurmdbd

      TCPTimeout=5

      SrunPortRange=60001-63000
      ResumeTimeout=600

    '';
  };
  # ==================== TODO: End Remove ====================

  systemd.services = {
    slurmdbd = {
      # For connection to localhost, mysql_real_connect
      # checks whether it can connect over a unix_socket.
      # This allows authentication by local user and removes
      # the need for a secret.
      #
      # To make this work, we need to set the environment variable
      # MYSQL_UNIX_PORT and let slurmdbd run as slurm instead of root
      # (done by `SlurmUser=slurm`).
      environment.MYSQL_UNIX_PORT = "/var/run/mysqld/mysqld.sock";
    };

    slurmctld = {
      preStart = ''
        # Delay starting so that `slurmdbd.service` can settle.
        sleep 1
      '';
      after = [ "slurmdbd.service" ];
      requires = [ "slurmdbd.service" ];
    };
  };

  networking.firewall.interfaces."enp1s0".allowedTCPPorts =
    [
      6817 # Default port for slurmctld
      #6819 # Default port for slurmdbd. Not needed, at it runs on localhost
    ];

  services = {
    slurm = {
      server.enable = true;

      dbdserver = {
        enable = true;
        extraConfig = ''
          PidFile=/run/slurmdbd.pid
          StorageHost=localhost
        '';
      };
    };

    mysql = {
      enable = true;
      package = pkgs.mariadb;

      ensureDatabases = [ "slurm_acct_db" ];
      ensureUsers = [{
        ensurePermissions = { "slurm_acct_db.*" = "ALL PRIVILEGES"; };
        name = "slurm";
      }];

      settings.mysqld = {
        bind-address = "localhost";

        # recommendations from: https://slurm.schedmd.com/accounting.html#mysql-configuration
        innodb_buffer_pool_size = "1024M";
        innodb_log_file_size = "64M";
        innodb_lock_wait_timeout = 900;
      };
    };
  };
}
