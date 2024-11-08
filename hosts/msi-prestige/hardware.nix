{ config, pkgs, lib, ... }: {
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ pkgs.linux-firmware ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "nvme"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" "iwlwifi" ];
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

  fileSystems."/boot" = {
    device = "/dev/nvme0n1p3";
    fsType = "vfat";
  };

  # CPU configuration
  powerManagement.cpuFreqGovernor = "performance";
  hardware.cpu.intel.updateMicrocode = true;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # WiFi and Bluetooth support
  networking = {

    hostName = "prestige";

    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };

    wireless = {
      enable = false;
      userControlled.enable = true;
      extraConfig = ''
        ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wheel
      '';
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # NVIDIA Configuration for PS63 Modern 8RC (GTX 1050 Max-Q)
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = true;
      finegrained = true;
    };

    open = false;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
    };

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable virtualisation on Nvidia GPU
  hardware.nvidia-container-toolkit.enable = true;

  # Add hardware related packages
  environment.systemPackages = with pkgs; [
    pciutils
    nvtop
    intel-gpu-tools
    glxinfo
    powertop
    tlp
    iw
    wirelesstools
    networkmanager
    networkmanagerapplet
    logiops
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    libva
    libva-utils
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
