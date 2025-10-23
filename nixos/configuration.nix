# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}@inputs:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.ssbm-nix.overlay
  ];
  # nixpkgs.overlays = [inputs.frc-nix.overlays.default];

  #styling
  stylix.enable = true;
  stylix.image = ../wallpapers/wallpaper.jpg;
  # stylix.image = "";
  # stylix.polarity = "dark";
  # stylix.fonts.serif.name = "Iosevka Nerd Font Mono";
  # stylix.fonts.serif.package = pkgs.nerd-fonts.iosevka;
  stylix.fonts.serif.name = "JetBrainsMono Nerd Font";
  stylix.fonts.serif.package = pkgs.nerd-fonts.jetbrains-mono;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/heetch.yaml";
  stylix.cursor = {
    name = "Bibata";
    package = pkgs.bibata-cursors;
    size = 32;
  };

  # Bootloader.
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "nodev";
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.useOSProber = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  environment.pathsToLink = [ "/libexec" ];
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    enable = true;
    # desktopManager = {
    #  	xterm.enable = false;
    #     xfce = {
    #     	enable = true;
    #     	noDesktop = true;
    #     	enableXfwm = false;
    #     };
    # };
    # displayManager.defaultSession = "xfce+i3";

    # # #displayManager.gdm.enable = true;
    # # #desktopManager.gnome.enable = true;
    # windowManager.i3 = {
    #     enable = true;
    #     extraPackages = with pkgs; [
    #     	i3status
    #     	i3lock
    #     ];
    # };
  };
  services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.churst = {
    isNormalUser = true;
    description = "churst";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "dialout"
    ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.useGlobalPkgs = true;

  services.flatpak.enable = true;
  services.teamviewer.enable = true;
  services.usbmuxd.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    slippi-launcher
    vim
    wl-clipboard
    pkgs.font-awesome
    pkgs.gh
    pkgs.unixtools.whereis
    # home-manager
    neovim
    pkgs.grim
    pkgs.slurp
    git
    kitty
    pkgs.pw-volume
    pkgs.waybar
    (pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
    pkgs.mako
    libnotify
    firefox
    pkgs.networkmanagerapplet
    unzip
    greetd.greetd
    greetd.tuigreet
    gcc
    zsh
    wget
    swaybg
    # hyprpaper
    pkgs.home-manager
    mangohud
    protonup
    #pkgs.pulseaudio
    pkgs.nix-search-cli
    # pkgs.xwaylandvideobridge
    pkgs.xdg-desktop-portal-wlr
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal
    pkgs.cmake
    pkgs.feh
    pkgs.eww
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.iosevka-term
    pkgs.nerd-fonts.comic-shanns-mono
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.playerctl
    pkgs.icu
    pkgs.swayidle
    pkgs.kanshi
    pkgs.java-language-server
    alejandra
    # pkgs.nerd-fonts.fira-code
    # pkgs.niri-stable
  ];
  services.pulseaudio.enable = false;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 1w --keep 3";
    flake = "${./.}";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  #niri
  # programs.niri.enable = true;
  # programs.niri.settings = {
  # };

  programs.river.enable = true;

  programs.hyprland = {
    enable = false;
    #enableNvidiaPatches = true;
    xwayland.enable = true;
  };

  #programs.sway = {
  #  enable = true;
  #  wrapperFeatures.gtk = true;
  #};

  programs.noisetorch.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    xorg.libX11
    xorg.libXcursor
    xorg.libxcb
    xorg.libXi
    libxkbcommon
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  # gaming stuff
  # I can do this in launch options on steam for better performance: gamemoderun gamescope %command% & if i want frame stuff i can add mangohud to that too!

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/churst/.steam/root/compatibilitytools.d";
  };

  programs.gamemode = {
    enable = true;
  };
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          gamemode
        ];
    };
  };
  hardware = {
    graphics = {
      enable = true;
      # driSupport32 = true;
      enable32Bit = true;
    };
    nvidia.modesetting.enable = true;
    nvidia.open = false;
    nvidia.nvidiaSettings = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # services.greetd = {
  #   enable = true;
  #   settings = rec {
  #     initial_session = {
  #       command = "tuigreet --user-menu --cmd ni";
  #       user = "churst";
  #     };
  #     default_session = initial_session;
  #   };
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-wlr
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal
  ];

  #sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
