{ pkgs, ... }: {
  programs.fish.enable = true;

  nix = {
    package = pkgs.nix;
    gc.automatic = true;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = false;
    };
  };

  nixpkgs.config.allowUnfree = true;

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
    lazydocker
    ripgrep
    ripgrep-all
    starship
    tmux
    unrar
    unzip
    wget
    zoxide
  ];

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
    font-awesome
    ubuntu_font_family
    dejavu_fonts
  ];
}
