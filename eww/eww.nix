{
  config,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/eww/eww.yuck" = {
      source = config.lib.file.mkOutOfStoreSymlink "${./.}/eww.yuck";
    };
    ".config/eww/eww.scss" = {
      source = config.lib.file.mkOutOfStoreSymlink "${./.}/eww.scss";
    };
  };
}
