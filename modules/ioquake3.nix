{ config, lib, pkgs, ... }:

with lib;

let
cfg = config.programs.quake3;
in {
  options.programs.quake3 = {
    enable = mkEnableOption "Quake 3 configuration";

    pakFile = mkOption {
      type = types.str;
      default = "pak0.pk3";
      description = "Name of the Quake 3 pak file to link";
    };
  };

  config = mkIf cfg.enable {
    home.file.".q3a/baseq3/${cfg.pakFile}".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Downloads/${cfg.pakFile}";

    home.packages = [ pkgs.ioquake3 ];
  };
}
