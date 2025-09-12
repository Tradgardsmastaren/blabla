{ config, pkgs, callPackage, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };
  # Configure console keymap
  console.keyMap = "sv-latin1";


  environment.sessionVariables = {
    # WLR_NO_HARDWARE_CURSORS = "1"; # Fix cursor invisibility (which made it worse for me)
    NIXOS_OZONE_WL = "1"; # Hint electron to use wayland
    # Proton-ge setup
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    graphics.enable = true; # NVIDIA driver settings
    nvidia = {
      modesetting.enable = true;
      #powerManagement.enable = false;
      #powerManagement.finegrained = false;
      open = false;
      #nvidiaSettings = true;
      #package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # For being able to run xremap without sudo
  hardware.uinput.enable = true;
  boot.kernelModules = [ "uinput" ];
  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
    '';
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixxer = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "nixxer";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "uinput" "input" ];
    packages = with pkgs; [
    #  kdePackages.kate
    #  thunderbird
    ];
  };




  programs = {
    # Hyprland
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    # Neovim as default editor
    neovim.defaultEditor = true;
    # Direnv for dev shells
    direnv.enable = true;
    # Fish
    fish = {
      enable = true;
      shellAliases = { 
        cd = "z";
        ls = "eza --icons -g";
        la = "eza --icons -la";
        ll = "eza --icons -l";
        v = "nvim";
        nixc = "sudoedit /etc/nixos/configuration.nix";
        nixr = "sudo nixos-rebuild switch";
      };
    };
    # Steam settings
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # Browsers
    brave	    # For privacy
    librewolf	# For privacy

    # Linux Desktop environment things
    waybar	            # Bar
    wofi	            # App launcher
    mako	            # Notifications
    hyprlock            # Lock
    hypridle            # Idle
    hyprpaper           # Wallpapers
    hyprshot            # Screenshot
    hyprsunset          # Blue-light
    pavucontrol         # Audio Settings

    # Terminals and CLI tools
    ghostty	    # Terminal testing
    eza		    # cool ls replacement
    zoxide	    # cd replacement
    unzip	    # Unzip zip files
    ripgrep	    # Grep alternative
    fd		    # Find alternative
    xremap	    # Personal keybindings

    # Dev things
    neovim 	         # Terminal editor
    git		         # Version control
    nixfmt-rfc-style # Nix formatting (maybe shouldn't be here)
    ((emacsPackagesFor emacs-pgtk).emacsWithPackages (
      epkgs: with epkgs; [
        treesit-grammars.with-all-grammars
        vterm
        mu4e
    ]))             # Emacs

    # Random apps
    obs-studio
    protonvpn-gui       # ProtonVPN
    vesktop	            # Discord client
    binutils            # For emacs
    mu                  # For mu4e emacs
    glib

    # Gaming
    protonup	# To install ProtonGE
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      cantarell-fonts           # Non-monospace
      nerd-fonts.roboto-mono    # No ligatures though
      nerd-fonts.fira-code 	    # Fira code fonts
      nerd-fonts.jetbrains-mono # Jetbrains mono nerd fonts
      nerd-fonts.symbols-only   # Symbols for Emacs
      font-awesome	   	        # Unicode fonts for waybar
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
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
  system.stateVersion = "25.05"; # Did you read the comment?

}
