{ pkgs, system, ... }: {
  programs.fish.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    bat
    btop
    curl
    dust
    fastfetch
    fish
    fzf
    gh
    git
    gitu
    helix
    ripgrep
    ripgrep-all
    starship
    tmux
    unrar
    unzip
    wget
    zed-editor
  ];

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
    font-awesome
    ubuntu_font_family
    dejavu_fonts
  ];
}
