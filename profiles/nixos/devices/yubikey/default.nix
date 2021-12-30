{ pkgs, ... }:
let
  inherit (builtins) attrValues;
in
{
  environment.systemPackages = attrValues {
    inherit (pkgs)
      gnupg
      yubico-piv-tool
      yubikey-manager
      #yubikey-neo-manager
      yubikey-personalization
      yubikey-personalization-gui;
      #yubioath-desktop
  };

  services.udev.packages = attrValues {
    inherit (pkgs)
      yubikey-personalization
      libu2f-host;
  };

  services.pcscd.enable = true;

  security.pam.u2f = {
    enable = true;
    cue = true;
  };

  # Setup GPG agent to emulate SSH agent.
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
  programs.ssh.startAgent = false;
}
