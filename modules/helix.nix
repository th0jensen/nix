{ pkgs, ... }: {
    programs.helix = {
        enable = true;
        package = pkgs.helix;
        settings = {
            theme = "gruber_darker";
            editor = {
                cursor-shape = {
                    insert = "bar";
                    normal = "block";
                    select = "underline";
                };
            };
            keys = {
                insert = {
                    "j" = { k = "normal_mode"; };
                    "k" = { j = "normal_mode"; };
                };
            };
        };
    };

    home.file.".config/helix/themes/gruber_darker.toml".text = ''
        # Gruber Darker theme, based on the Zed theme
        # Author: Converted from Zed theme

        # General editor colors
        "ui.background" = { bg = "#191919" }
        "ui.text" = "#d1c7c5"
        "ui.virtual.whitespace" = "#545454"
        "ui.cursor" = { bg = "#ffdd33", fg = "#191919" }
        "ui.cursor.primary" = { bg = "#ffdd33", fg = "#191919" }
        "ui.cursor.match" = { bg = "#ffdd33", fg = "#191919" }        
        "ui.selection" = { bg = "#737373b3" }
        "ui.linenr" = "#545454"
        "ui.linenr.selected" = "#ffdd33"
        "ui.statusline" = { fg = "#d1c7c5", bg = "#191919" }
        "ui.statusline.inactive" = { fg = "#95a99f", bg = "#191919" }
        "ui.popup" = { bg = "#191919" }
        "ui.window" = { bg = "#191919" }
        "ui.help" = { fg = "#d1c7c5", bg = "#191919" }
        "ui.menu" = { fg = "#d1c7c5", bg = "#191919" }
        "ui.menu.selected" = { fg = "#d1c7c5", bg = "#303030" }

        # Diagnostic colors
        "diagnostic.error" = { fg = "#f43841" }
        "diagnostic.warning" = { fg = "#ffdd33" }
        "diagnostic.info" = { fg = "#96a6c8" }
        "diagnostic.hint" = { fg = "#707070" }

        # Special highlights
        "special" = "#ffdd33"
        "error" = "#f43841"
        "warning" = "#ffdd33"
        "info" = "#96a6c8"
        "hint" = "#707070"

        # Syntax highlighting
        "type" = "#d1c7c5"
        "constant" = { fg = "#95a99f", modifiers = ["bold"] }
        "constant.numeric" = "#d1c7c5"
        "constant.character.escape" = { fg = "#7cc138", modifiers = ["italic"] }
        "string" = { fg = "#7cc138", modifiers = ["italic"] }
        "string.regexp" = { fg = "#7cc138", modifiers = ["italic"] }
        "string.special" = { fg = "#7cc138", modifiers = ["italic"] }
        "comment" = { fg = "#cc8c3c" }
        "variable" = "#d1c7c5"
        "variable.builtin" = "#d1c7c5"
        "variable.parameter" = "#d1c7c5"
        "variable.other" = "#d1c7c5"
        "label" = "#95a99f"
        "punctuation" = "#d1c7c5"
        "punctuation.delimiter" = "#d1c7c5"
        "punctuation.bracket" = "#d1c7c5"
        "keyword" = { fg = "#ffdd33", modifiers = ["bold"] }
        "keyword.control" = { fg = "#ffdd33", modifiers = ["bold"] }
        "keyword.function" = { fg = "#ffdd33", modifiers = ["bold"] }
        "keyword.operator" = "#d1c7c5"
        "function" = "#96a6c8"
        "function.builtin" = "#96a6c8"
        "function.macro" = "#96a6c8"
        "tag" = "#d1c7c5"
        "namespace" = { fg = "#ffdd33", modifiers = ["bold"] }
        "attribute" = { fg = "#95a99f", modifiers = ["italic"] }
        "constructor" = { fg = "#ffdd33", modifiers = ["bold"] }
        "operator" = "#d1c7c5"

        # Markup
        "markup.heading" = { fg = "#ffdd33", modifiers = ["bold"] }
        "markup.list" = "#d1c7c5"
        "markup.bold" = { modifiers = ["bold"] }
        "markup.italic" = { modifiers = ["italic"] }
        "markup.link.url" = { fg = "#96a6c8", modifiers = ["underlined"] }
        "markup.link.text" = "#96a6c8"
        "markup.quote" = { fg = "#95a99f", modifiers = ["italic"] }
        "markup.raw" = "#68685b"

        # Diff
        "diff.plus" = "#73c936"
        "diff.minus" = "#f43841"
        "diff.delta" = "#cc8c3c"
    '';
}
