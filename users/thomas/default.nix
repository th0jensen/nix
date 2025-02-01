{ pkgs, ... }: {
  imports = [
    ../../modules/fish.nix
    ../../modules/ghostty.nix
    ../../modules/helix.nix
    ../../modules/starship.nix
    ../../modules/zellij.nix
    ../../modules/zed.nix
  ];

  home.packages = with pkgs; [
    cmatrix
    discord
    dosbox-staging
    nixd
    rustup
    zed-editor
  ];

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
