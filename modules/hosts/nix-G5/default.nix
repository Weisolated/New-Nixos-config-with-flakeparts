{ self, inputs, ... }: {


  flake.nixosConfigurations.nix-G5 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.nix-G5Configuration
      self.nixosModules.myHomeManager  
    ];
  };


}
