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

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
    font-awesome
    ubuntu_font_family
    dejavu_fonts
  ];
}
