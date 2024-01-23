{ system, pkgs, self, ... }:

rec {
  mediaproc = pkgs.writeShellApplication {
    name = "mediaproc";
    runtimeInputs = with pkgs; [ bash gnumake coreutils findutils inotify-tools ];
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
