{ self, inputs, pkgs, ... }: {

 flake.homeModules.xxxxxModule = { pkgs, ... }: {

  xdg.desktopEntries.helium-browser = {
  name = "Helium Browser";
  exec = "appimage-run /home/xxxxx/AppImages/helium.appimage %U";
  terminal = false;
  categories = [ "Network" "WebBrowser" ];
  icon = "/home/xxxxx/AppImages/.icons/helium.png";
  type = "Application";
};



xdg.desktopEntries.mcpelauncher-nvidia = {
  name = "Minecraft Bedrock (NVIDIA)";
  exec = "flatpak run --env=__NV_PRIME_RENDER_OFFLOAD=1 --env=__GLX_VENDOR_LIBRARY_NAME=nvidia --env=__VK_LAYER_NV_optimus=NVIDIA_only io.mrarm.mcpelauncher run";
  terminal = false;
  categories = [ "Game" ];
  icon = "io.mrarm.mcpelauncher";
};

     xdg.desktopEntries.mcpelauncher-x11 = {
    name = "Minecraft Bedrock X11";
    exec = "flatpak run --nosocket=fallback-x11 --socket=x11 io.mrarm.mcpelauncher";
    terminal = false;
    categories = [ "Game" ];
    icon = "io.mrarm.mcpelauncher";
  };


  };
}
