{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    "/home/churst/.config/kitty/kitty.conf" = {
      executable = true;
      text = ''
        background #${config.lib.stylix.colors.base00}
        font_family family="${config.stylix.fonts.serif.name}"
        foreground #${config.lib.stylix.colors.base05}
        shell fish
        confirm_os_window_close 0
        allow_remote_control yes

        map ctrl+tab launch --type os-window --cwd current
      '';
    };
  };
}
