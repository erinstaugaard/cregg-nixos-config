{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    "/home/churst/.config/mako/config" = {
      executable = true;
      text = ''
        background-color=#${config.lib.stylix.colors.base00}
        border-color=#${config.lib.stylix.colors.base0D}
        text-color=#${config.lib.stylix.colors.base0A}
        border-radius=25
        font=${config.stylix.fonts.serif.name}
        width=370
      '';
    };
  };
}
