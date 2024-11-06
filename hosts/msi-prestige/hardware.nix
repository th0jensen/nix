{ pkgs, ... }: {

  # Disks
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/e55ada70-5227-4dfa-83df-3e358f00206e";
    fsType = "ext4";
  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/bf78e8de-b1d1-442a-aa9e-9a9ed95b2032"; } ];

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel        # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Add hardware related packages
    environment.systemPackages = with pkgs; [
      pciutils    # Provides lspci
      nvtop       # GPU monitoring
      intel-gpu-tools
      glxinfo
    ];

  # Load nvidia driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend issues.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not nouveau).
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Prime configuration for laptops with hybrid graphics
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Make sure these bus IDs match your hardware
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Optional: For better power management
  services.thermald.enable = true;
}
