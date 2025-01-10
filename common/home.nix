{ pkgs, ... }: {
  home.packages = with pkgs; [
    bat
    btop
    cmatrix
    discord
    dust
    eza
    fastfetch
    fish
    fzf
    gh
    git
    gitu
    helix
    nixd
    rustup
    starship
    tmux
    unrar
    unzip
    wget
  ];

  programs.home-manager.enable = true;
}
