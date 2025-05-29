{ pkgs, ... }:
let
  fisher = pkgs.fetchFromGitHub {
    owner = "jorgebucaran";
    repo = "fisher";
    rev = "4.4.4";
    sha256 = "sha256-e8gIaVbuUzTwKtuMPNXBT5STeddYqQegduWBtURLT3M=";
  };
in {
  programs.fish = {
    enable = true;
    package = pkgs.fish;
    plugins = [
      { name = "fisher"; src = fisher; }
    ];

    shellInit = ''
      fish_add_path /opt/homebrew/sbin
      fish_add_path /opt/homebrew/bin
      fish_add_path /opt/homebrew/opt/ruby/bin
      fish_add_path $HOME/.local/bin
      fish_add_path /run/current-system/sw/bin
      fish_add_path /run/wrappers/bin
      fish_add_path /etc/profiles/per-user/thomas/bin
      fish_add_path $HOME/.cargo/bin
      fish_add_path $HOME/.orbstack/bin
      fish_add_path $HOME/.bun/bin
      fish_add_path $HOME/.ce/bin
      fish_add_path $HOME/.config/emacs/bin

      set -U fish_greeting
    '';

    shellAliases = {
      prestige = "ssh thomas@prestige";
      cd = "z";
      la = "eza -al --color=always --icons --group-directories-first";
      ls = "eza -a --color=always --icons  --group-directories-first";
      ll = "eza -l --color=always --icons --group-directories-first";
      lt = "eza -aT --color=always --icons --group-directories-first";
      "l." = "eza -a | egrep '^\\.'";
      rg = "rga-fzf";
    };

    interactiveShellInit = ''
      fzf --fish | source
      zoxide init fish | source
      # Install Fisher if not already installed
      if not functions -q fisher
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
      end
      # Install Tide if not already installed
      if not functions -q tide
        fisher install IlanCosman/tide@v6
      end
      # Install nvm.fish if not already installed
      if not functions -q nvm
        fisher install jorgebucaran/nvm.fish@2.2.13
      end
      # Install autopair if not already installed
      if not functions -q _autopair_uninstall
        fisher install jorgebucaran/autopair.fish
      end
    '';
  };

  home.packages = with pkgs; [
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
    tmux
    unrar
    unzip
    wget
    zoxide
  ];
}
