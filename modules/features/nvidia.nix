{ self, inputs, ... }: {

  flake.nixosModules.nvidia = { config, pkgs, ... }: {

 hardware.graphics = {
	enable = true;
	extraPackages = with pkgs; [
        intel-media-driver
        libva-vdpau-driver
      ];
    };


 nixpkgs.config.packageOverrides = pkgs: {
 	vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
 	}; 

environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";       # Intel VA-API (für Videos)
    WLR_DRM_DEVICES = "/dev/dri/by-path/pci-0000:00:02.0-card";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";  # GLX für NVIDIA (XWayland-Apps)
  __NV_PRIME_RENDER_OFFLOAD = "1"; # ✅ Erzwingt NVIDIA für Offload-Apps
    __VK_LAYER_NV_optimus = "NVIDIA_only";  # ✅ Vulkan auf NVIDIA-GPU
};

environment.variables = {
  VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json";
  VK_LAYER_PATH = "/run/opengl-driver/share/vulkan/implicit_layer.d";
};

 hardware.nvidia = {

        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
	powerManagement.enable = false;
	powerManagement.finegrained = false;
};

 hardware.nvidia.prime = {
	offload.enable = true;
	offload.enableOffloadCmd = true;
	intelBusId = "PCI:0:2:0";
	nvidiaBusId = "PCI:1:0:0";
	};

boot.kernelParams = [
    "nvidia-drm.modeset=1"           # Wayland-Kompatibilität
    "nvidia.NVreg_DynamicPowerManagement=0x02"  # Besseres Powermanagement
  ];

services.xserver = {
  # ✅ X11 komplett deaktiviert!
    videoDrivers = [ "nvidia" ];  # Nur falls XWayland gebraucht wird
  };
};
}


