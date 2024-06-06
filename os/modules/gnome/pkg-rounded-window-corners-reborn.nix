{
  pkgs,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage rec {
  pname = "rounded-window-corners";
  version = "61c326e3d6cba36fe3d07cf1c15e6c74d3f9abb1";

  src = fetchFromGitHub {
    owner = "flexagoon";
    repo = pname;
    rev = version;
    sha256 = "sha256-jS6G9wSKSXAxNhCmuew6pTcYa1gTZqbfrcAZ0ky4vkc=";
  };

  nativeBuildInputs = with pkgs; [
    glib.dev
    just
  ];

  npmDepsHash = "sha256-2brE1GlzyHN9G/161aKiuHVVbjrpnN/0FBwuBDg/8W0=";
  dontNpmBuild = true;
  installPhase = ''
    just build
    mkdir -p $out/share/gnome-shell/extensions
    cp -R ./_build/ $out/share/gnome-shell/extensions/rounded-window-corners@fxgn
  '';

  npmPackFlags = ["--ignore-scripts"];

  NODE_OPTIONS = "--openssl-legacy-provider";

  meta = {
    description = "Rounded window corners GNOME extension";
  };
}
