{ pkgs, ... }: {
    programs.fish = {
        enable = true;
        interactiveShellInit = ''
            fish_add_path /opt/homebrew/sbin
            fish_add_path /opt/homebrew/bin
            fish_add_path /opt/homebrew/opt/ruby/bin
            fish_add_path $HOME/.local/bin
            fish_add_path /run/current-system/sw/bin
            fish_add_path /run/wrappers/bin
            fish_add_path /etc/profiles/per-user/thomas/bin
            fish_add_path $HOME/.deno/bin

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

            # Install Fisher if not already installed
            # Install nvm.fish plugin
            if not functions -q fisher
                curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
                fisher install jorgebucaran/nvm.fish
            end
        '';

        plugins = [];
    };
}
