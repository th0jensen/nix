{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  home.activation.doomEmacs = ''
    if [ ! -d "$HOME/.config/emacs" ]; then
      ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs $HOME/.config/emacs
      $HOME/.config/emacs/bin/doom install
    fi
  '';

  home.sessionPath = [ "$HOME/.config/emacs/bin" ];

  home.packages = with pkgs; [
    git
    ripgrep
    fd
  ];
}
