{
  description = "Duke3D packaged with DOSBox Staging";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    dosbox-staging.url = "github:dosbox-staging/dosbox-staging";
  };

  outputs = { self, nixpkgs, dosbox-staging }: {
    packages.x86_64-linux = let
      duke3d = nixpkgs.pkgs.stdenv.mkDerivation {
        pname = "duke3d";
        version = "1.0";

        src = nixpkgs.pkgs.fetchzip {
          url = "https://archive.org/download/DUKE3D_DOS/DUKE3D.zip";
          sha256 = "sha256-0hxg4p06q91q94701yfnjdpr88720iwmk0niw4rj793wa9x72zjc";
        };

        installPhase = ''
          mkdir -p $out/bin
          cp -r $src/* $out/bin/
          ln -s $out/bin/DUKE3D.EXE $out/bin/duke3d
          ln -s $out/bin/SETUP.EXE $out/bin/setup
        '';

        nativeBuildInputs = [ dosbox-staging ];
      };
    in {
      duke3d = duke3d;

      # Desktop entries
      desktopEntries = {
        duke3d = {
          name = "Duke3D";
          exec = "${duke3d}/bin/DUKE3D.EXE";
          icon = "duke3d";
          type = "Application";
          categories = [ "Game" ];
        };

        setup = {
          name = "Duke3D Setup";
          exec = "${duke3d}/bin/SETUP.EXE";
          icon = "duke3d";
          type = "Application";
          categories = [ "Game" ];
        };
      };
    };
  };
}
