# Profile for headless machine, mostly SSH related.
{ ... }:
{

  # TODO check efficacy
  security.sudo.wheelNeedsPassword = false;

  # Enable sudo logins if the user's SSH agent
  # provides a key present in ~/.ssh/authorized_keys.
  security.pam.enableSSHAgentAuth = true;

  # Enable SSH logins over port 22 via key only.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    startWhenNeeded = true;
    passwordAuthentication = false;
    #permitRootLogin = "no" would break nixops?;
  };

  # Does what it says on the tin.
  services.sshguard.enable = true;
}
