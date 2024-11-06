{ config, pkgs, lib, ... }: {
  imports = [ ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    # For better SSD support
    kernel.sysctl = {
      "vm.swappiness" = 10;
    };
  };

  # Disks
  fileSystems."/" = {
    device = "/dev/nvme0n1p1";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/nvme0n1p2"; }
  ];

  # CPU configuration
  powerManagement.cpuFreqGovernor = "performance";
  hardware.cpu.intel.updateMicrocode = true;

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # WiFi and Bluetooth support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  networking.wireless = {
    enable = false;  # Disable wpa_supplicant as we're using NetworkManager
    iwd.enable = true;  # Enable iwd for better WiFi performance
  };

  # NVIDIA Configuration for PS63 Modern 8RC (GTX 1050 Max-Q)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = {
      enable = true;
      finegrained = false;
    };
    open = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Bus IDs for PS63 Modern 8RC
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Add hardware related packages
  environment.systemPackages = with pkgs; [
    pciutils
    nvtop
    intel-gpu-tools
    glxinfo
    powertop
    tlp
    iw
  ];

  # Power management
  services = {
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
      };
    };
  };
}
