{ pkgs, ... }: {
  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+ep";
    source = "${pkgs.sunshine}/bin/sunshine";
  };

  systemd.services.sunshine = {
    description = "Sunshine streaming service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" "display-manager.service" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.sunshine}/bin/sunshine";
      Restart = "always";
      User = "thomas";

      Environment = [
        "DISPLAY=:0"
        "XAUTHORITY=/home/thomas/.Xauthority"
        "XDG_RUNTIME_DIR=/run/user/1000"
        "PULSE_SERVER=unix:/run/user/1000/pulse/native"
      ];

      RuntimeDirectory = "sunshine";
      RuntimeDirectoryMode = "0755";

      LidSwitchIgnoreInhibited = "yes";
      StandardOutput = "journal";
      StandardError = "journal";
    };
  };

  environment.etc."sunshine/sunshine.conf".text = ''
    min_log_level = "Info"
    origin_web_ui_allowed = ["100.0.0.0/8"]
    origin_pin_allowed = ["100.0.0.0/8"]
    encoder = "nvenc"
    min_bitrate = 10
    max_bitrate = 50
    hevc_mode = "0"
    back_button_timeout = 100
    key_repeat_delay = 100
    gamepad = true
    virtual_gamepad = true
    virtual_sink = false
    cmd_before_session = "xset dpms force on"
    cmd_after_session = "xset dpms force on"
  '';

  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;

  environment.systemPackages = with pkgs; [
    sunshine
    avahi
  ];
}
