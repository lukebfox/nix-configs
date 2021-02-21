{ ... }:
{
  # Note: you'll need to add your user to 'vboxusers' group to use VirtualBox.
  virtualisation.virtualbox.host = {
    enable = true;
    enableHardening = false;
    enableExtensionPack = true;
  };
}
