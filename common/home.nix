{ pkgs, ... }: {
  home.packages = with pkgs; [
    bat
    btop
    discord
    dust
    eza
    fastfetch
    fish
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
