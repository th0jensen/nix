{ pkgs, ... }: {
  programs.zed-editor = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then
    pkgs.runCommand "zed-editor-dummy" {
      meta.mainProgram = "zed-editor";
    } ''
      mkdir -p $out/bin
      echo "#!/bin/sh" > $out/bin/zeditor
      echo "exec /Applications/Zed\ Preview.app/Contents/MacOS/zed \"\$@\"" >> $out/bin/zeditor
      chmod +x $out/bin/zeditor
    ''
    else pkgs.zed-editor;

    extensions = [ "gruber-darker" ];

    userSettings = {
      active_pane_modifiers = {
        inactive_opacity = 0.85;
      };
      bottom_dock_layout = "left_aligned";
      vim_mode = false;
      theme = "Gruber Darker - Minimal";
      ui_font_family = "JetBrainsMono Nerd Font";
      ui_font_size = if pkgs.stdenv.isDarwin then 16 else 13;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = if pkgs.stdenv.isDarwin then 15 else 12;
      unstable.ui_density = "comfortable";
      terminal = {
        dock = "bottom";
        shell = "system";
        env = {
          TERM = "xterm-ghostty";
        };
        toolbar = {
          breadcrumbs = false;
        };
        button = true;
        working_directory = "current_project_directory";
      };
      features = {
        inline_completion_provider = "none";
      };
      tab_bar = {
        show_nav_history_buttons = false;
      };
      tabs = {
        file_icons = true;
        git_status = false;
      };
      soft_wrap = "editor_width";
      cursor_blink = false;
      show_whitespaces = "none";
      toolbar = {
        breadcrumbs = false;
        quick_actions = false;
        selections_menu = false;
      };
      scrollbar = {
        show = "never";
      };
      assistant = {
        default_model = {
          provider = "zed.dev";
          model = "claude-3-5-sonnet-latest";
        };
        dock = "right";
        version = "2";
        button = true;
      };
      project_panel = {
        folder_icons = true;
        dock = "left";
        scrollbar = {
          show = "never";
        };
      };
      outline_panel = {
        button = false;
        dock = "left";
      };
      notification_panel = {
        button = false;
        dock = "left";
      };
      collaboration_panel = {
        button = false;
        dock = "left";
      };
      chat_panel = {
        button = false;
        dock = "left";
      };
      jupyter = {
        dock = "right";
        enabled = true;
        default_width = 320;
        kernel_selections = {
          javascript = "deno";
          typescript = "deno";
          sql = "xsql";
        };
      };
      tab_size = 4;
      format_on_save = "on";
      formatter = "language_server";
      languages = {
        HTML = {
          prettier = {
            allowed = true;
          };
        };
        JavaScript = {
          prettier = {
            allowed = true;
          };
        };
        TypeScript = {
          prettier = {
            allowed = true;
          };
        };
        TSX = {
          prettier = {
            allowed = true;
          };
        };
        CSS = {
          prettier = {
            allowed = true;
          };
        };
        Swift = {
          enable_language_server = true;
          language_servers = [
            "sourcekit-lsp"
          ];
          formatter = "language_server";
          format_on_save = "on";
        };
      };
      prettier = {
        arrowParens = "always";
        bracketSpacing = true;
        bracketSameLine = true;
        htmlWhitespaceSensitivity = "never";
        insertPragma = false;
        jsxSingleQuote = true;
        printWidth = 80;
        proseWrap = "always";
        quoteProps = "as-needed";
        requirePragma = false;
        semi = false;
        singleQuote = true;
        tabWidth = 4;
        trailingComma = "es5";
        useTabs = false;
      };
      auto_update = true;
      auto_update_extensions = {
        enable = true;
      };
      inlay_hints = {
        enabled = true;
      };
    };

    userKeymaps = [
      {
        bindings = {
          cmd-r = "task::Spawn";
          shift-cmd-r = "task::Rerun";
          alt-x = "command_palette::Toggle";
          cmd-b = "workspace::ToggleLeftDock";
          cmd-t = "workspace::ToggleBottomDock";
          cmd-s = "workspace::Save";
          cmd-enter = "repl::Run";
          cmd-g = [
            "task::Spawn"
            {
              task_name = "Gitu";
            }
          ];
        };
      }
    ];
  };
}
