{ pkgs, lib, ... }:

let
  duke3d = pkgs.stdenv.mkDerivation {
    pname = "duke3d";
    version = "1.0";

    src = pkgs.fetchzip {
      url = "https://archive.org/download/DUKE3D_DOS/DUKE3D.zip";
      sha256 = "sha256-0hxg4p06q91q94701yfnjdpr88720iwmk0niw4rj793wa9x72zjc";
    };

    installPhase = ''
      mkdir -p $out/bin
      cp -r $src/* $out/bin/
      ln -s $out/bin/DUKE3D.EXE $out/bin/duke3d
      ln -s $out/bin/SETUP.EXE $out/bin/setup
    '';

    nativeBuildInputs = [ pkgs.dosbox-staging ];
  };

  createDesktopEntry = { name, exec, icon, type, categories }:
      ''
        [Desktop Entry]
        Name=${name}
        Exec=${exec}
        Icon=${icon}
        Type=${type}
        Categories=${lib.strings.concatStringsSep ";" categories};
      '';

    desktopEntries = {
      duke3d = createDesktopEntry {
        name = "Duke3D";
        exec = "dosbox ${duke3d}/bin/DUKE3D.EXE";
        icon = "duke3d";
        type = "Application";
        categories = [ "Game" ];
      };

      setup = createDesktopEntry {
        name = "Duke3D Setup";
        exec = "dosbox ${duke3d}/bin/SETUP.EXE";
        icon = "duke3d";
        type = "Application";
        categories = [ "Game" ];
      };
    };
in
{
  inherit duke3d;

  home.file."duke3d.desktop".text = desktopEntries.duke3d;
  home.file."duke3d-setup.desktop".text = desktopEntries.setup;
}
