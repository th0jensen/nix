{ pkgs, ... }: {
  home.packages = with pkgs; [
    bat
    bruno
    btop
    discord
    dust
    eza
    fastfetch
    fzf
    gh
    git
    gitu
    neovim
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
