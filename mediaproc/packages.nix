{ system, lib, pkgs, self, runtimeInputs, ... }:

rec {
  mediaproc-extract_date = pkgs.writeShellApplication {
    name = "extract_date";
    runtimeInputs = runtimeInputs ++ [
      mediaproc-extract_exif_date
      mediaproc-extract_filename_date
    ];
    text = lib.readFile ./scripts/extract_date;
  };

  mediaproc-extract_exif_date = pkgs.writeShellApplication {
    name = "extract_exif_date";
    inherit runtimeInputs;
    text = lib.readFile ./scripts/extract_exif_date;
  };

  mediaproc-extract_filename_date = pkgs.writeShellApplication {
    name = "extract_filename_date";
    inherit runtimeInputs;
    text = lib.readFile ./scripts/extract_filename_date;
  };

  mediaproc = pkgs.writeShellApplication {
    name = "mediaproc";
    runtimeInputs = runtimeInputs ++ [
      mediaproc-extract_date
      mediaproc-extract_filename_date
      mediaproc-extract_exif_date
    ];
    text = ''
      make -C ${./.} -j
    '';
  };

  mediaproc-docker = pkgs.dockerTools.buildImage {
    name = "negrel/unixcloud-mediaproc";
    tag = "latest";

    config = {
      Cmd = [ "${self.packages.${system}.mediaproc}/bin/mediaproc" ];
      WorkingDir = "/app";
    };
  };
}
