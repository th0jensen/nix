{ pkgs, ... }:
let
  nvm-fish = pkgs.fetchFromGitHub {
    owner = "jorgebucaran";
    repo = "nvm.fish";
    rev = "2.2.13";
    sha256 = "sha256-LV5NiHfg4JOrcjW7hAasUSukT43UBNXGPi1oZWPbnCA=";
  };
in {
  programs.fish = {
    enable = true;
    package = pkgs.fish;
    plugins = [
      { name = "nvm"; src = nvm-fish; }
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

      set -U fish_greeting
      set -x ZELLIJ_AUTO_ATTACH true
    '';

    shellAliases = {
      prestige = "ssh thomas@prestige";
      la = "eza -al --color=always --icons --group-directories-first";
      ls = "eza -a --color=always --icons  --group-directories-first";
      ll = "eza -l --color=always --icons --group-directories-first";
      lt = "eza -aT --color=always --icons --group-directories-first";
      "l." = "eza -a | egrep '^\\.'";
      rg = "rga-fzf";
    };

    interactiveShellInit = ''
      fzf --fish | source
      starship init fish | source
      zoxide init fish | source

      if status is-interactive; and not set -q ZELLIJ; and not set -q SSH_CLIENT; and test "$TERM" != "dumb"
        if command -v zellij > /dev/null
          zellij attach --index 0 || zellij
        end
      end
    '';
  };
}
