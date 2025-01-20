{ pkgs ? import <nixpkgs> {} }:
let
  duke3d = pkgs.stdenv.mkDerivation {
    pname = "duke3d";
    version = "1.0";
    src = pkgs.fetchzip {
      url = "https://archive.org/download/DUKE3D_DOS/DUKE3D.zip";
      stripRoot = false;
      sha256 = "sha256-DcUAYKZx1/vSm6sJZn+Hqbh0hw1GhiVMwrl0RPMTPZE=";
    };
    installPhase = ''
      mkdir -p $out/bin
      cp -r * $out/bin/
      ln -s $out/bin/DUKE3D.EXE $out/bin/duke3d
      ln -s $out/bin/SETUP.EXE $out/bin/setup
    '';
    nativeBuildInputs = [ pkgs.dosbox-staging ];
  };
in
{
  inherit duke3d;
}
