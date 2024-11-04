{ pkgs, ... }: {
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
                decorations = "Buttonless";
                padding = {
                    x = 10;
                    y = 10;
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
            fish_add_path /run/current-system/sw/bin
            fish_add_path /etc/profiles/per-user/thomas/bin
            fish_add_path /Users/thomas/.deno/bin

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

            # Set up Python
            set -Ux PYENV_ROOT $HOME/.pyenv
            set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

            # Load pyenv automatically by appending
            # the following to ~/.config/fish/config.fish:

            pyenv init - | source

            # Install Fisher if not already installed
            # Install nvm.fish plugin
            if not functions -q fisher
                curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
                fisher install jorgebucaran/nvm.fish
            end
        '';

        plugins = [];
    };

    programs.starship = {
        enable = true;
        settings = {
            "$schema" = "https://starship.rs/config-schema.json";
            command_timeout = 1000;
            scan_timeout = 1000;

            line_break = {
                disabled = true;
            };

            character = {
                success_symbol = "[➜](bold green)";
                error_symbol = "[✗](bold red)";
                vimcmd_symbol = "[➜](bold green)";
                vimcmd_replace_one_symbol = "[➜](bold purple)";
                vimcmd_visual_symbol = "[➜](bold yellow)";
                vimcmd_replace_symbol = "[➜](bold purple)";
            };

            jobs = {
                disabled = true;
            };
        };
    };

    home.file.".aerospace.toml".text = ''
    # Start AeroSpace at login
    start-at-login = true

    # Normalization settings
    enable-normalization-flatten-containers = true
    enable-normalization-opposite-orientation-for-nested-containers = true

    # Accordion layout settings
    accordion-padding = 30

    # Default root container settings
    default-root-container-layout = 'tiles'
    default-root-container-orientation = 'auto'

    # Automatically unhide macOS hidden apps
    automatically-unhide-macos-hidden-apps = true

    # Key mapping preset
    [key-mapping]
    preset = 'qwerty'

    # Gaps settings
    [gaps]
    inner.horizontal = 10
    inner.vertical =   10
    outer.left =       10
    outer.bottom =     10
    outer.top =        10
    outer.right =      10

    # Main mode bindings
    [mode.main.binding]
    # Launch applications
    cmd-shift-enter = 'exec-and-forget open -na alacritty'
    alt-shift-b = 'exec-and-forget open -a "Brave Browser"'
    alt-shift-t = 'exec-and-forget open -a "Telegram"'
    alt-shift-f = 'exec-and-forget open -a Finder'

    # Window management
    alt-q = "close"
    alt-slash = 'layout tiles horizontal vertical'
    alt-comma = 'layout accordion horizontal vertical'
    alt-m = 'fullscreen'

    # Focus movement
    alt-h = 'focus left'
    alt-j = 'focus down'
    alt-k = 'focus up'
    alt-l = 'focus right'

    # Window movement
    alt-shift-h = 'move left'
    alt-shift-j = 'move down'
    alt-shift-k = 'move up'
    alt-shift-l = 'move right'

    # Resize windows
    alt-shift-minus = 'resize smart -50'
    alt-shift-equal = 'resize smart +50'

    # Workspace management
    alt-1 = 'workspace 1'
    alt-2 = 'workspace 2'
    alt-3 = 'workspace 3'
    alt-4 = 'workspace 4'
    alt-5 = 'workspace 5'
    alt-6 = 'workspace 6'
    alt-7 = 'workspace 7'
    alt-8 = 'workspace 8'
    alt-9 = 'workspace 9'

    # Move windows to workspaces
    alt-shift-1 = 'move-node-to-workspace 1'
    alt-shift-2 = 'move-node-to-workspace 2'
    alt-shift-3 = 'move-node-to-workspace 3'
    alt-shift-4 = 'move-node-to-workspace 4'
    alt-shift-5 = 'move-node-to-workspace 5'
    alt-shift-6 = 'move-node-to-workspace 6'
    alt-shift-7 = 'move-node-to-workspace 7'
    alt-shift-8 = 'move-node-to-workspace 8'
    alt-shift-9 = 'move-node-to-workspace 9'

    # Workspace navigation
    alt-tab = 'workspace-back-and-forth'
    alt-shift-tab = 'move-workspace-to-monitor --wrap-around next'

    # Enter service mode
    alt-shift-semicolon = 'mode service'

    # Service mode bindings
    [mode.service.binding]
    # Reload config and exit service mode
    esc = ['reload-config', 'mode main']

    # Reset layout
    r = ['flatten-workspace-tree', 'mode main']

    # Toggle floating/tiling layout
    f = ['layout floating tiling', 'mode main']

    # Close all windows but current
    backspace = ['close-all-windows-but-current', 'mode main']

    # Join with adjacent windows
    alt-shift-h = ['join-with left', 'mode main']
    alt-shift-j = ['join-with down', 'mode main']
    alt-shift-k = ['join-with up', 'mode main']
    alt-shift-l = ['join-with right', 'mode main']

    # Window detection rules
    [[on-window-detected]]
    if.app-id = 'com.brave.Browser'
    run = 'move-node-to-workspace 1'

    [[on-window-detected]]
    if.app-id = 'org.alacritty'
    run = 'move-node-to-workspace 2'

    [[on-window-detected]]
    if.app-id = 'com.tdesktop.Telegram'
    run = 'move-node-to-workspace 3'

    [[on-window-detected]]
    if.app-id = 'com.spotify.client'
    run = 'move-node-to-workspace 4'

    [[on-window-detected]]
    if.app-id = 'com.obsproject.obs-studio'
    run = 'move-node-to-workspace 4'

    [[on-window-detected]]
    if.app-id = 'us.zoom.xos'
    run = 'move-node-to-workspace 5'
    '';
}
