{ config, pkgs, lib,  ... }: {
    home.username = "thomas";
    home.homeDirectory = "/Users/thomas";
    home.stateVersion = "23.11";

    home.packages = with pkgs; [
        alacritty
        arc-browser
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
        iina
        neovim
        nixd
        rustup
        starship
        tmux
        unrar
        unzip
        wget
        zoom-us
    ];

    # Add more program configurations as needed
    # Add this line to use a different activation approach
    programs.home-manager.enable = true;
}
