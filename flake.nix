{
  description = "Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... } @inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./nixos/configuration.nix ];
        };
      };

      homeConfigurations = {
        "manan" = home-manager.lib.homeManagerConfiguration {
          # Home-manager requires 'pkgs' instance
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ 
            ./home-manager/home.nix 
            hyprland.homeManagerModules.default
            {
              wayland.windowManager.hyprland = {
                enable = true; 
		extraConfig = builtins.readFile( ./hypr/hyprland.conf );
              };
            }
          ];
        };
      };
    };
}
