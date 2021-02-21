final: prev: {
  # More recent picom (20/10/20).
  # includes dual-kawase blur method
  picom = prev.picom.overrideAttrs (_: {
    src = prev.fetchFromGitHub {
      owner = "yshui";
      repo = "picom";
      rev = "00ee5cb4b1a6e97a9b0a32b87d44c6ef8d542806";
      sha256 = "1q12jbwwmp7k4fzdlwv44c7h4icd94v094rfrvgc8wv7b6xhq7qm";
    };
  });
}
