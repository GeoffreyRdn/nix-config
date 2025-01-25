# Edit this configuration file to define what should be installed on your system
# Help is available in the configuration.nix(5) man page and in the
# NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{ imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    # Use the systemd-boot EFI boot loader.
    # boot.loader.systemd-boot.enable = true;
    # boot.loader.efi.canTouchEfiVariables = true;

    boot.loader.grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        theme = pkgs.stdenv.mkDerivation rec {
            pname = "catppuccin-grub";
            version = "1";
            src = pkgs.fetchFromGitHub {
                owner = "catppuccin";
                repo = "grub";
                rev = "803c5df";
                hash = "sha256-/bSolCta8GCZ4lP0u5NVqYQ9Y3ZooYCNdTwORNvR7M0=";
            };
            installPhase = "
                mkdir -p $out
                cp -r src/catppuccin-mocha-grub-theme/* $out/
            ";
            meta = {
            description = "catppuccin-grub";
            };
        };
    };

    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot";

    networking.hostName = "nixos"; # Define your hostname.

    # Pick only one of the below networking options.

    # Enables wireless support via wpa_supplicant.
    # networking.wireless.enable = true;

    # Easiest to use and most distros use this by default.
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Paris";

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        useXkbConfig = true; # use xkbOptions in tty.
    };

    environment.pathsToLink = [ "/libexec" ];

    # Enable the X11 windowing system.
    services = {
	    xserver = {
            enable = true;
            videoDrivers = [ "amdgpu" ];
            xkb.layout = "us";
            desktopManager = {
                xterm.enable = false;
            };

	        windowManager.i3 = {
	            enable = true;
		        extraPackages = with pkgs; [
                    dmenu
                    i3status
                    i3lock
                    i3blocks
                ];
            };

            displayManager = {
                sessionCommands = ''
                  feh --bg-scale "$HOME/.wallpapers/skull-gruv.png"
                  xrandr --output DisplayPort-0 --primary --rate 144 --left-of HDMI-A-0 --output HDMI-A-0 --auto
                  polybar &
                  picom &
                '';
	        };
        };

        # Handle USB
        gvfs.enable = true;
        udisks2.enable = true;

        displayManager = {
            defaultSession = "none+i3";
        };
    };

    services.picom = {
        enable = true;
        vSync = true;
    };

    systemd.user.services.mpris-proxy = {
        description = "Mpris proxy";
        after = [ "network.target" "sound.target" ];
        wantedBy = [ "default.target" ];
        serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };


    # enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # services.xserver.xkbOptions = "eurosign:e,caps:escape";

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

    # enables support for Bluetooth
    hardware.bluetooth.enable = true;
    # powers up the default Bluetooth controller on boot
    hardware.bluetooth.powerOnBoot = true;

    hardware.bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    users.defaultUserShell = pkgs.zsh;
    programs = {
    zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        zsh-autoenv.enable = true;
        syntaxHighlighting.enable = true;

        ohMyZsh = {
            enable = true;
            plugins = [
                "git"
                "docker"
                "python"
                "man"
                "colored-man-pages"
                "sudo"
              ];
            };
        };
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.geoffrey = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "audio" "docker" ];
            packages = with pkgs; [
                firefox
                tree
            ];
        shell = pkgs.zsh;
    };

    virtualisation.docker.enable = true;

    documentation.dev.enable = true;

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.pulseaudio = true;

    fonts.fontconfig.enable = true;
    fonts.packages =  with pkgs; [
        (nerdfonts.override {
            fonts = [
                "JetBrainsMono"
            ];
        })
    ];

    # List packages installed in system profile.
    # To search, run: $ nix search wget
    environment.systemPackages = with pkgs; [
            vim                         # vim
            neovim                      # neovim
            i3                          # i3
            wget                        # get requests
            arandr                      # xrandr visualization

            polybar                     # better bar
            betterlockscreen            # screen locker
            keepassxc                   # passwords utility

            patchelf                    # patch nixos executables
            autoPatchelfHook            # patch nixos executables

            actkbd                      # keyboard shortcut
            brightnessctl               # luminosity handler

            zsh                         # zsh editor
            oh-my-zsh                   # zsh upgraded
            dash                        # dash editor

            alacritty                   # alacritty terminal
            fzf                         # fuzzy finder

            bat                         # better cat
            feh                         # display images
            unzip                       # unzip
            direnv                      # diremv

            imagemagick                 # import

            man-pages                   # man pages
            man-pages-posix             # man pages

            pavucontrol                 # audio control

            gnumake                     # gnu compiler
            clang-tools                 # clang compiler
            gcc                         # C compiler
            gdb                         # C Debugger

            jdk                         # java
            python312                   # python

            vscode                      # vscode IDE
            jetbrains.idea-ultimate     # IDEA IDE
            jetbrains.clion             # clion IDE
            jetbrains.rider             # rider IDE

            # Utils
            git                         # git
            xsel                        # read/write tool

            google-chrome

            discord                     # discord
            slack                       # slack

            prismlauncher               # minecraft

            picom                       
            dunst
            eww

            nixfmt-rfc-style
            ];

    # Some programs need SUID wrappers
    # Can be configured further or are started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true; enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];

    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix).
    # This is useful in case you accidentally delete configuration.nix.
    system.copySystemConfiguration = true;

    # This value determines the NixOS release from which the default settings
    # for stateful data, like file locations and database versions on your
    # system were taken. It's perfectly fine and recommended to leave this
    # value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?
}
