{
  pkgs,
  config,
  lib,
  pkgs-unstable,
  ...
}:
with builtins;
with lib;
{

  networking.firewall = {
    allowedTCPPorts = [
      12865
    ];
    allowedUDPPorts = [
      24454
      5553
    ];
  };

  networking.wireguard = {
    enable = true;

    # environment.systemPackages = with pkgs; [
    #   iptables
    # ];

    interfaces.wg0 = {
      ips = [ "100.64.0.4/24" ];
      listenPort = 5553;

      privateKeyFile = config.sops.secrets."wg_private_key".path;

      peers = [
        {
          publicKey = "4OwrGOuxS93ICxQwJN+el4vyunkGlsaVOqHsXZNWnDM=";
          endpoint = "69.48.200.159:5180";
          allowedIPs = [ "100.64.0.0/24" ];
          persistentKeepalive = 25;
        }
      ];

    };
  };
  sops.secrets."wg_private_key" = { };
}
