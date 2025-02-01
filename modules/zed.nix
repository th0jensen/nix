{ pkgs, config, lib, ... }: {
  home.activation.setupZedConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    zed_config_dir="$HOME/.config/zed"
    zed_settings="$zed_config_dir/settings.json"

    mkdir -p "$zed_config_dir"

    # Remove symlink if it exists
    if [ -L "$zed_settings" ]; then
      rm "$zed_settings"
    fi

    # Create new file with content
    cat > "$zed_settings" << 'EOL'
{
  "active_pane_modifiers": {
    "inactive_opacity": 0.85
  },
  "assistant": {
    "button": true,
    "default_model": {
      "model": "claude-3-5-sonnet-latest",
      "provider": "zed.dev"
    },
    "dock": "right",
    "version": "2"
  },
  "auto_install_extensions": {
    "gruber-darker": true
  },
  "auto_update": true,
  "auto_update_extensions": {
    "enable": true
  },
  "bottom_dock_layout": "left_aligned",
  "buffer_font_family": "JetBrainsMono Nerd Font",
  "buffer_font_size": 15,
  "chat_panel": {
    "button": false,
    "dock": "left"
  },
  "collaboration_panel": {
    "button": false,
    "dock": "left"
  },
  "cursor_blink": false,
  "features": {
    "inline_completion_provider": "none"
  },
  "format_on_save": "on",
  "formatter": "language_server",
  "inlay_hints": {
    "enabled": true
  },
  "jupyter": {
    "default_width": 320,
    "dock": "right",
    "enabled": true,
    "kernel_selections": {
      "javascript": "deno",
      "sql": "xsql",
      "typescript": "deno"
    }
  },
  "language_models": {
    "ollama": {
      "api_url": "http://100.100.50.3:11434/"
    }
  },
  "languages": {
    "CSS": {
      "prettier": {
        "allowed": true
      }
    },
    "HTML": {
      "prettier": {
        "allowed": true
      }
    },
    "JavaScript": {
      "prettier": {
        "allowed": true
      }
    },
    "Swift": {
      "enable_language_server": true,
      "format_on_save": "on",
      "formatter": "language_server",
      "language_servers": [
        "sourcekit-lsp"
      ]
    },
    "TSX": {
      "prettier": {
        "allowed": true
      }
    },
    "TypeScript": {
      "prettier": {
        "allowed": true
      }
    }
  },
  "notification_panel": {
    "button": false,
    "dock": "left"
  },
  "outline_panel": {
    "button": false,
    "dock": "left"
  },
  "prettier": {
    "arrowParens": "always",
    "bracketSameLine": true,
    "bracketSpacing": true,
    "htmlWhitespaceSensitivity": "never",
    "insertPragma": false,
    "jsxSingleQuote": true,
    "printWidth": 80,
    "proseWrap": "always",
    "quoteProps": "as-needed",
    "requirePragma": false,
    "semi": false,
    "singleQuote": true,
    "tabWidth": 4,
    "trailingComma": "es5",
    "useTabs": false
  },
  "project_panel": {
    "dock": "left",
    "folder_icons": true,
    "scrollbar": {
      "show": "never"
    }
  },
  "scrollbar": {
    "show": "never"
  },
  "show_whitespaces": "none",
  "soft_wrap": "editor_width",
  "ssh_connections": [
    {
      "host": "prestige",
      "projects": [
        {
          "paths": [
            "~/nix"
          ]
        }
      ]
    }
  ],
  "tab_bar": {
    "show_nav_history_buttons": false
  },
  "tab_size": 4,
  "tabs": {
    "file_icons": true,
    "git_status": false
  },
  "terminal": {
    "button": true,
    "dock": "bottom",
    "env": {
      "TERM": "xterm-ghostty"
    },
    "shell": {
      "program": "/nix/store/dsxx1ihv1dxi0ip377c2jcyz9kn144kd-fish-3.7.1/bin/fish"
    },
    "toolbar": {
      "breadcrumbs": false
    },
    "working_directory": "current_project_directory"
  },
  "theme": "Gruber Darker",
  "toolbar": {
    "breadcrumbs": false,
    "quick_actions": false,
    "selections_menu": false
  },
  "ui_font_family": "JetBrainsMono Nerd Font",
  "ui_font_size": 16,
  "unstable": {
    "ui_density": "comfortable"
  },
  "vim_mode": false
}
EOL

    chmod 644 "$zed_settings"
  '';
}
