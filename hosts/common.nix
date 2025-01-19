{ pkgs, ... }: {
  programs.fish.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  nix.package = pkgs.nix;
  nix.gc.automatic = true;
  nix.settings.auto-optimise-store = false;

  environment.systemPackages = with pkgs; [
    bat
    btop
    curl
    dust
    eza
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
