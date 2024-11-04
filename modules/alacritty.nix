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
}
