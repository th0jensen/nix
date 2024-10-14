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
        bun
        discord
        dolphin-emu
        dust
        eza
        fzf
        gh
        git
        iina
        neofetch
        neovim
        raycast
        ripgrep-all
        skhd
        starship
        tmux
        unrar
        unzip
        yabai
        wget
        zoom-us
    ];

    programs.alacritty = {
        enable = true;
        settings = {
            shell = {
                program = "${pkgs.fish}/bin/fish";
            };
            font = {
                normal = {
                    family = "JetBrainsMono Nerd Font";
                };
                size = 15;
            };
            window = {
                decorations = "transparent";
                padding = {
                    x = 0;
                    y = 5;
                };
            };
        };
    };

    programs.fish = {
        enable = true;
        interactiveShellInit = ''
            fish_add_path /opt/homebrew/sbin
            fish_add_path /opt/homebrew/bin
            fish_add_path /opt/homebrew/opt/ruby/bin
            fish_add_path /Users/thomas/.local/bin
            fish_add_path /etc/profiles/per-user/thomas/bin

            set -U fish_greeting ""

            # Aliases
            alias gitignore='gitignore_edit'
            alias license='create_license'
            alias dev_server='connect_server'
            alias la='eza -al --color=always --icons --group-directories-first'
            alias ls='eza -a --color=always --icons  --group-directories-first'
            alias ll='eza -l --color=always --icons --group-directories-first'
            alias lt='eza -aT --color=always --icons --group-directories-first'
            alias l.='eza -a | egrep "^\."'
            alias ta='tmux attach'
            alias rg="rga-fzf"

            fzf --fish | source

            starship init fish | source
        '';

        plugins = [
        # You can add Fish plugins here if needed
        ];
    };

    programs.starship = {
        enable = true;
    };

    programs.git = {
        enable = true;
    };

    # Add more program configurations as needed
    # Add this line to use a different activation approach
    programs.home-manager.enable = true;
}
