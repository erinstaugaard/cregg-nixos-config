{
  config,
  pkgs,
  ...
}:
{
  programs.waybar = {
    enable = true;
    # package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-left = [
          "custom/power"
          "river/tags"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "tray"
        ];
        "river/tags" = {
          "hide-vacant" = true;
        };
        "custom/power" = {
          "on-click" = "bash ~/.config/waybar/power.sh";
          format = "<span color='#${config.lib.stylix.colors.base05}'></span>";
        };
        clock = {
          format = "  {:%a %b %d  %I:%M %p}";
          tooltip = true;
        };
        battery = {
          format = "{capacity}%  ";
        };
        network = {
          interface = "wlo1";
          format = "{ifname}";
          format-wifi = "<span color='#${config.lib.stylix.colors.base05}'>  </span>{essid}";
          format-ethernet = "{ipaddr}/{cidr}";
          format-disconnected = "<span color='#${config.lib.stylix.colors.base05}'>󰖪 </span>No Network";
          tooltip = false;
        };
        pulseaudio = {
          format = "<span color='#${config.lib.stylix.colors.base05}'>{icon} </span> {volume}%";
          format-muted = "";
          tooltip = false;
          format-icons = {
            headphone = "";
            default = [
              ""
              ""
              "󰕾"
              "󰕾"
              "󰕾"
              ""
              ""
              ""
            ];
          };
          scroll-step = 1;
        };
      }
    ];

    style = ''
      * {
        border: none;
        font-family: '${config.stylix.fonts.serif.name}';
        font-size: 16px;
        font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
        min-height: 45px;
      }


      window#waybar {
        background: transparent;
      }

      #custom-power, #workspaces {
        border-radius: 10px;
        background-color: #${config.lib.stylix.colors.base00};/*#1D2321;*/
        color: #${config.lib.stylix.colors.base05};
        margin-top: 15px;
        margin-right: 15px;
        padding-top: 1px;
        padding-left: 20px;
        padding-right: 28px;
      }

      #custom-power {
        font-size: 20px;
        margin-left: 15px;
        color: #${config.lib.stylix.colors.base00};
      }

      #tags button {
        margin-top: 15px;
        background: none; 
      }
      #tags button.focused {
        margin-top: 15px;
        background-color: #${config.lib.stylix.colors.base00};
      }

      #clock, #backlight, #pulseaudio, #tray, #network, #battery{
        border-radius: 10px;
        background-color: #${config.lib.stylix.colors.base00};
        color: #${config.lib.stylix.colors.base05};
        margin-top: 15px;
        padding-left: 10px;
        padding-right: 10px;
        margin-right: 15px;
      }

      #network {
        border-radius: 0px;
        margin-right: 0px;
      }

      #pulseaudio {
        border-top-right-radius: 0;
        border-bottom-right-radius: 0;
        padding-right: 5px;
        margin-right: 0
      }

      #tray {
        border-top-left-radius: 0;
        border-bottom-left-radius: 0;
        padding-left: 5px;
        margin-left: 0;
      }

      #clock {
        margin-right: 0;
      }

      #clock > *:nth-child(1) {
        margin-right: 20px;
      }
    '';
  };
}
