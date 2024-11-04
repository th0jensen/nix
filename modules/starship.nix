{ pkgs, ... }: {
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
}
