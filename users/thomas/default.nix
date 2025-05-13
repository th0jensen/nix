{ pkgs, ... }: {
  imports = [
    ../../modules/fish.nix
    ../../modules/ghostty.nix
    ../../modules/helix.nix
    # ../../modules/zed.nix
  ];

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    cmatrix
    discord
    dosbox-staging
    nixd
    rustup
  ];

  # TODO: Add Thunderbird module with configuration

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  programs.git = {
    userName = "Thomas Jensen";
    userEmail = "thomas.jensen_@outlook.com";
    extraConfig = {
      core.editor = "hx";
    };
  };

  programs.home-manager.enable = true;
}
