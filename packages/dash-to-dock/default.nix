{ lib, stdenv
, fetchFromGitHub
, glib
, gettext
, sassc
}:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-dash-to-dock";
  version = "unstable-2021-10-31";

  # temporarily switched to commit hash because GNOME 41 version is not released yet.
  src = fetchFromGitHub {
    owner = "micheleg";
    repo = "dash-to-dock";
    rev = "a23f0c5efa82d8dca767dd323436c5998373f139";
    sha256 = "sha256-jqdwXvkfWz1XhWA3al9YIGDoJJG+ODaB/uGAor+kZok=";
  };

  nativeBuildInputs = [
    glib
    gettext
    sassc
  ];

  makeFlags = [
    "INSTALLBASE=${placeholder "out"}/share/gnome-shell/extensions"
  ];

  passthru = {
    extensionUuid = "dash-to-dock@micxgx.gmail.com";
    extensionPortalSlug = "dash-to-dock";
  };

  meta = with lib; {
    description = "A dock for the Gnome Shell";
    homepage = "https://micheleg.github.io/dash-to-dock/";
    license = licenses.gpl2;
    maintainers = with maintainers; [ eperuffo jtojnar ];
  };
}
