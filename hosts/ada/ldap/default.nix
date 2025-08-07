{ pkgs, ... }:
{
  services.openldap = {
    enable = true;

    #urlList = [ "ldap://aiken.ce.pdn.ac.lk/" ];
    urlList = [ "ldap:///" ];

    settings = {
      attrs = {
        olcLogLevel = "conns config";
      };

      children = {
        "cn=schema".includes = [
          "${pkgs.openldap}/etc/schema/core.ldif"
          "${pkgs.openldap}/etc/schema/cosine.ldif"
          "${pkgs.openldap}/etc/schema/inetorgperson.ldif"
          "${pkgs.openldap}/etc/schema/nis.ldif"
        ];

        "olcDatabase={1}mdb".attrs = {
          objectClass = [ "olcDatabaseConfig" "olcMdbConfig" ];

          olcDatabase = "{1}mdb";
          olcDbDirectory = "/var/lib/openldap/data";

          olcSuffix = "dc=ce,dc=pdn,dc=ac,dc=lk";

          olcRootDN = "cn=ceadmin,dc=ce,dc=pdn,dc=ac,dc=lk";
          olcRootPW = "{SSHA}5+J/KmkOVJCR1Civ6JtDrMrvwoB+M7Fh";

          olcAccess = [
            /* custom access rules for userPassword attributes */
            ''{0}to attrs=userPassword
                by self write
                by anonymous auth
                by * none''

            /* allow read on anything else */
            ''{1}to *
                by * read''
          ];
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 389 ];
}
