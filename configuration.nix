# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:



{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];	#Bootloader.  
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = ["nodev"];
  #boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  networking.hostName = "kusneidNotebook"; # Define your hostname.
  
  # Enable networking
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  system.autoUpgrade.enable  = true;
  system.autoUpgrade.allowReboot  = false;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us, ru";
  };

  services.resolved.enable = true;

  services.postgresql = {
    enable = true;
    dataDir = "/var/lib/postgresql/data";  # Каталог для данных
    authentication = pkgs.lib.mkOverride 10 ''
      # TYPE  DATABASE        USER            ADDRESS                 METHOD
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            md5
      host    all             all             ::1/128                 md5
    '';
    initialScript = pkgs.writeText "init.sql" ''
      CREATE ROLE admin WITH LOGIN PASSWORD 'secret' SUPERUSER;
      CREATE DATABASE bd_labs OWNER admin;
    '';
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kusneid = {
    isNormalUser = true;
    description = "Vladislav Baydakov";
    extraGroups = [ "docker" "networkmanager" "wheel" "input"];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Allow unfree package
  nixpkgs.config.allowUnfree = true;

  programs.hyprland.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.theme = "Elegant";

  virtualisation.docker.enable = true;

  #services.displayManager.lightdm.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  fonts.packages = with pkgs; [
	roboto
	material-icons
    	roboto-mono
  ];

  environment.systemPackages = with pkgs; [
  	#steam
	steam-run

	elegant-sddm
  	os-prober
	gsettings-desktop-schemas

	#lightdm
		
	gnome-settings-daemon
    	gtk4
    	gtk3
    	polkit
	glib
	killall
	vim
	wget
	roboto-flex
	hyprland
	kitty
	blueman
	docker
	bluez
	bluez-tools
	networkmanagerapplet
   	hyprshot
    	hyprpaper
	htop
   	waybar
	git
	rofi-wayland
	yazi
	dunst
	hypridle
	hyprlock
	wlogout
	neovim
	wl-clipboard
	cliphist
	pamixer
	playerctl
	brightnessctl 
#	xorg.xhost
	pipewire
	pavucontrol	
	power-profiles-daemon
	sddm
	btrfs-progs
];

  programs = {

   steam = {
	enable = true;
	remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
	dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
   };

   zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
	  "git"
          "kubectl"
          "helm"
          "docker"
        ];
      };
    };
  };

  users.defaultUserShell = pkgs.zsh;


  services.power-profiles-daemon.enable = true;
  programs.git.enable = true;
  #Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
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
  system.stateVersion = "24.11"; # Did you read the comment?

}
