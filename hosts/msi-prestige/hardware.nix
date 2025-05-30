{ config, pkgs, ... }: {

  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ pkgs.linux-firmware ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" "iwlwifi" ];
    kernel.sysctl = {"vm.swappiness" = 10; };
    kernelParams = [ "intel_pstate=active" "processor.ignore_ppc=1" ];
    kernelPatches = [
        {
          name = "Rust Support";
          patch = null;
          features = {
            rust = true;
          };
        }
    ];
    extraModulePackages = [ ];

    initrd = {
      verbose = false;
      kernelModules = [ ];
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
    };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
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
  # Note: Removed xserver.videoDrivers for Wayland compatibility

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

  # Enable Wayland support for NVIDIA
  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Enable virtualisation on Nvidia GPU
  hardware.nvidia-container-toolkit = {
    enable = true;
    suppressNvidiaDriverAssertion = true;
  };

  # Add hardware related packages
  environment.systemPackages = with pkgs; [
    pciutils
    nvtopPackages.full
    intel-gpu-tools
    glxinfo
    powertop
    usbutils
    tlp
    iw
    wirelesstools
    networkmanager
    networkmanagerapplet
    nvidia-docker
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    libva
    libva-utils

    # Wayland tools
    wlr-randr
    wayland-utils
    egl-wayland
  ];

  # Power management
  services = {
    thermald = {
      enable = true;
      configFile = pkgs.writeText "thermal-conf.xml" ''
        <?xml version="1.0"?>
        <ThermalConfiguration>
        <ThermalZones>
        <ThermalZone>
        <Type>cpu</Type>
        <TripPoints>
        <TripPoint>
        <SensorType>x86_pkg_temp</SensorType>
        <Temperature>75000</Temperature>
        <type>passive</type>
        <ControlType>PARALLEL</ControlType>
        <CoolingDevice>
        <index>1</index>
        <type>rapl_controller</type>
        <influence>100</influence>
        <SamplingPeriod>5</SamplingPeriod>
        </CoolingDevice>
        </TripPoint>
        </TripPoints>
        </ThermalZone>
        </ThermalZones>
        </ThermalConfiguration>
      '';
    };

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
        CPU_MAX_PERF_ON_BAT = 60;
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_MIN_FREQ_ON_AC = 800000;
        CPU_SCALING_MAX_FREQ_ON_AC = 4600000;
        CPU_SCALING_MIN_FREQ_ON_BAT = 800000;
        CPU_SCALING_MAX_FREQ_ON_BAT = 2000000;
      };
    };
  };
}
