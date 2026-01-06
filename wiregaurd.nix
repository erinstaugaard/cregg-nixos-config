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
    allowedUDPPorts = [
      0000
      24454
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
          publicKey = "1WNIMazFPdpTuFKnWEZDKDhTdJaI2lUR6aH1kEuKiBw=";
          endpoint = "69.48.200.159:5180";
          allowedIPs = [ "100.64.0.0/24" ];
          persistentKeepalive = 25;
        }
      ];

    };
  };
  sops.secrets."wg_private_key" = { };
}
