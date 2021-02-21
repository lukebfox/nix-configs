{ shared, ... }:
let
  inherit (shared.network) domain;
in
{
  imports = [ ../nginx/reverse-proxy.nix ];

  # MPD music player
  # Listens for remote commands on 6600
  # Streams to localhost:8010
  services.mpd = {
    enable = true;
    network.port = 6600;
    network.listenAddress = "0.0.0.0"; # Controlled remotely
    musicDirectory = "/Music";
    extraConfig = ''
      log_level "verbose"
      audio_output {
        type      "shout"
        encoding  "ogg"
        name      "MPD Stream"
        mount     "/mpd.ogg"
        host      "localhost"
        port      "8010"
        user      "source"
        password  "hackme"
        encoder   "vorbis"
        #bitrate   "320"     # do not define if quality is defined
        format    "44100:16:2"
        always_on "yes"     # prevent MPD from disconnecting all listeners when playback is stopped.
        tags      "yes"     # httpd supports sending tags to listening streams.
      }
      audio_output {
        type "null"
        name "fallback (null)"
      }
    '';
  };

  services.nginx.virtualHosts."music.${domain}" = {
    useACMEHost = domain;
    forceSSL = true;
    locations = {
      "/mpd" = {
        proxyPass = "http://localhost:6600";
        proxyWebsockets = true;
      };
    };
  };

}
