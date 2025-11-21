{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix/release-24.11";
    niri.url = "github:sodiboo/niri-flake";
    ssbm-nix.url = "github:normalfall/ssbm-nix";
    frc-nix.url = "github:frc4451/frc-nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };
    in
    {
      homeConfigurations."churst" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./common.nix
          ./home.nix
          inputs.stylix.homeManagerModules.stylix
        ];
      };
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = inputs;

          modules = [
            inputs.stylix.nixosModules.stylix
            inputs.niri.nixosModules.niri
            ./common.nix
            ./nixos/configuration.nix

            # home-manager.nixosModules.home-manager
            # {
            #   home-manager.backupFileExtension = "hm-backup";
            #   home-manager.useGlobalPkgs = true;
            #   home-manager.users.churst = import ./home.nix;
            # }
          ];
        };
        # live = nixpkgs.lib.nixosSystem {
        #   system = "x86_64-linux";
        #   modules = [
        #     ./isoimage.nix
        #     ./nixos/configuration.nix
        #     inputs.stylix.nixosModules.stylix

        #     home-manager.nixosModules.home-manager {
        #       home-manager.backupFileExtension = "hm-backup";
        #       home-manager.useGlobalPkgs = true;
        #       home-manager.users.churst = import ./home.nix;
        #     }
        #   ];
        # };
      };
    };
}
