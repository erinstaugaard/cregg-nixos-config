{
  config,
  pkgs,
  lib,
  ...
}:
{
  #styling
  stylix.enable = true;
  stylix.image = ./wallpapers/wallpaper.jpg;
  # stylix.image = "";
  # stylix.polarity = "dark";
  # stylix.fonts.serif.name = "Iosevka Nerd Font Mono";
  # stylix.fonts.serif.package = pkgs.nerd-fonts.iosevka;
  # stylix.fonts.serif.name = "JetBrainsMono Nerd Font";
  # stylix.fonts.serif.package = pkgs.nerd-fonts.jetbrains-mono;
  stylix.fonts.serif.name = "MartianMono Nerd Font";
  stylix.fonts.serif.package = pkgs.nerd-fonts.martian-mono;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/embers.yaml"; # "${pkgs.base16-schemes}/share/themes/heetch.yaml";
  stylix.cursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 32;
  };

}
