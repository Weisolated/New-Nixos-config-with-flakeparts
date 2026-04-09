{ self, inputs, ... }: {

  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.xxxxx = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.xxxxxModule
      {
        home.username = "xxxxx";
        home.homeDirectory = "/home/xxxxx";
      }
    ];
  };

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  flake.homeModules.xxxxxModule = { pkgs, ... }: {
    home.stateVersion = "24.11";

  home.packages = with pkgs; [
	

];

  home.pointerCursor = {
    name = "GoogleDot-White";
    package = pkgs.google-cursor;
    size = 22;
    gtk.enable = true;
    x11.enable = true;
  };

  };

}
