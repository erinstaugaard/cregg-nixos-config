{appimageTools}: let
  version = "3.4.2";
in
  appimageTools.wrapType2 {
    name = "slippi-online";
    extraPkgs = pkgs: [pkgs.gmp pkgs.mpg123 pkgs.libmpg123 pkgs.curl];

    src = builtins.fetchurl {
      url = "https://github.com/project-slippi/Ishiiruka/releases/download/v${version}/Slippi_Online-x86_64.AppImage";
      sha256 = "138z8a2hpfcv4nn90d1gbfnzmcq50whkkpaab3pg8fhdxqvx4yv1";
    };
  }
