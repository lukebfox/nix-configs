{
  wsl = {
    enable = true;
    wslConf = {
      automount.root = "/mnt";
      interop.enabled = true;
      interop.appendWindowsPath = true;
      user.default = "lukebfox";
    };
    nativeSystemd = true; # new wsl2
    defaultUser = "lukebfox";
    
    startMenuLaunchers = true;

    # Enable native Docker support
    #docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    #docker-desktop.enable = true;
  };
}
