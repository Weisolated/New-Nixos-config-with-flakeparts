{ self, inputs, ... }: {

  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
  package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };


  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
    
settings = {
      
       layout.gaps = 15; 

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

     binds = {
          "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
          "Mod+Q".close-window = _: {};
          
        };
};

      "config.kdl".path = "/home/xxxxx/NixOS/modules/features/config.kdl";

        "config.kdl".content = "";
    };
  };
}


