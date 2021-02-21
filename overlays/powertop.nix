final: prev: {
  powertop = prev.powertop.overrideAttrs (old: {
    #buildInputs = old.buildInputs ++ [ final.bluez ];
    postPatch = old.postPatch + ''
      substituteInPlace src/tuning/bluetooth.cpp --replace "/usr/bin/hcitool" "hcitool"
    '';
  });
}
