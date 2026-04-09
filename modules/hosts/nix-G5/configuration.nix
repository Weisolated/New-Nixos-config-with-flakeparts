{ self, inputs, ... }: {

  flake.nixosModules.nix-G5Configuration = { config, pkgs, inputs, ... }:
{
  imports = [
	self.nixosModules.nix-G5Hardware
    self.nixosModules.niri
    self.nixosModules.nvidia
    self.nixosModules.flatpak
    self.nixosModules.virt
	]; 

home-manager.users.xxxxx = self.homeModules.xxxxxModule;

 users.users.xxxxx = {
    isNormalUser = true;
    description = "xxxxx";
    extraGroups = [ "networkmanager" "wheel" ];
   shell = pkgs.fish;
 };


  environment.systemPackages = with pkgs; [
    xwayland-satellite
    ghostty
    mangohud
    protonup-ng
    wine
    winetricks
    vulkan-loader
    mesa
    libva
    mpv
    ffmpeg
    tela-circle-icon-theme
    appimage-run
    unrar # Tool For Handling .rar Files
    unzip # Tool For Handling .zip Files
    btop-cuda
    fuzzel
    cava
    lxqt.lxqt-policykit
    libappimage
    nvtopPackages.full 
    wineWow64Packages.waylandFull
#    xeyes
    git
    # Python + GTK Layer Shell
    (python3.withPackages (ps: with ps; [
      pygobject3
      pillow
    ]))
    gtk3
    gtk-layer-shell
  gobject-introspection
   nemo-with-extensions
umu-launcher
	adw-gtk3
	nwg-look
	kdePackages.qt6ct
	lutris
	goverlay
mangojuice	
    heroic
	bitwarden-desktop
	joplin-desktop
	protonplus
	libreoffice-fresh
	hunspell
	hunspellDicts.de_DE
	hyphenDicts.de_DE
	onlyoffice-desktopeditors
	brave
	filen-desktop
#  sushi
	prismlauncher
	vesktop
	pavucontrol
	fastfetch	
	gpu-screen-recorder
	gpu-screen-recorder-gtk
	librewolf
	gnome-clocks
#	gnome-weather
	gnome-calendar
	gnome-calculator
	gnome-disk-utility
	papers
	loupe
	bazaar
	gnome-text-editor
#	faugus-launcher
#	spicetify-cli
	yazi
	tree
	xed-editor
	komikku
    nautilus
    video-trimmer
    switcheroo
    gnome-sudoku
    shortwave
    resources
    gnome-obfuscate
    gradia
    constrict
    cemu
    pkgs.google-cursor
];


 qt.platformTheme = "qt6ct";
 programs.localsend.openFirewall = true;
 programs.localsend.enable = true;
 programs.steam.enable = true;
 programs.steam.gamescopeSession.enable = true;
 programs.gamemode.enable = true;
 #programs.home-manager.enable = true;

boot.kernelParams = [
  "quiet"
  "splash"
  "loglevel=3"
  "rd.systemd.show_status=false"
  "systemd.show_status=false"
];

boot.consoleLogLevel = 0;
services = {
      spice-vdagentd.enable = true;
      libinput.enable = true;
      upower.enable = true;
      power-profiles-daemon.enable = true;
    };


  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

services.xserver = {
    enable = true;  
  };
 services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

#Mullvad DNS Setup
#services.resolved = {
 # enable = true;
  #settings = {
   # Resolve = {
    #  DNS = [ "194.242.2.4#base.dns.mullvad.net" ];
     # DNSSEC = "no";
     # DNSOverTLS = "yes";
    #  Domains = [ "~." ];
   # };
  #};
#};


# Service for IPad-PC connection
services.usbmuxd = {
  enable = true;
  package = pkgs.usbmuxd2;
};


#?????????
programs.nix-ld.enable = true;

#services.displayManager.gdm = {
#    enable = true;
#    wayland = true;
#};

  # Session für GDM registrieren
  services.displayManager.sessionPackages = [
    pkgs.niri
  ];

  # Pflicht für Wayland
  services.dbus.enable = true;
  security.polkit.enable = true;
 
 fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        inter
	corefonts
      ];
      fontconfig = {
        enable = true;
        defaultFonts = {
          sansSerif = [
            "Inter"
            "Noto Sans"
          ];
          serif = [ "Noto Serif" ];
          monospace = [ "JetBrainsMono Nerd Font" ];
        };
      };
      fontDir.enable = true;
    };

hardware.bluetooth.enable = true;

services.udisks2.enable = true;
services.gvfs.enable = true;
programs.dconf.enable = true;
xdg.portal.wlr.enable = true;

services.printing = {
  enable = true;
  drivers = with pkgs; [
    cups-filters
    cups-browsed
  ];
};


 boot.loader.systemd-boot.enable = true;
 boot.loader.efi.canTouchEfiVariables = true;

 boot.kernelPackages = pkgs.linuxPackages_latest;

 networking.hostName = "nixos";
 networking.networkmanager = {
  enable = true;
  #dns = "systemd-resolved";

	#settings = {
	#main = {
     # 		dns = "systemd-resolved";
    	#	};
  #  connection = {
    #  "ipv4.ignore-auto-dns" = "true";
    #  "ipv6.ignore-auto-dns" = "true";
   # };
  #};
};


 time.timeZone = "Europe/Berlin";

 i18n.defaultLocale = "de_DE.UTF-8";

 i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };


 console.keyMap = "de";

 services.pulseaudio.enable = false;
 security.rtkit.enable = true;
 services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
};

 nixpkgs.config.allowUnfree = true;
 nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true; 
  };
  networking.firewall = {
    enable = true;
  }; 

 system.stateVersion = "25.11"; 

services.greetd = {
  enable = true;

  settings = {
    default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet \
        --time \
        --remember \
        --remember-session \
        --cmd niri";
      user = "greeter";
    };
  };
};
#services.displayManager.ly = {
#    enable = true;
#  };
#  environment.systemPackages = with pkgs; [
#    niri
#
#  ];
#  services.seatd.enable = true;
#

};

}
