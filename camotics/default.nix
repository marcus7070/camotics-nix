{ 
  lib
  , mkDerivationWith
  , stdenv
  , fetchFromGitHub
  , scons
  , cbang
  , qt5Full
  , v8
  , six
  , pkgconfig
  , snappy
  , dxflib
  , wrapQtAppsHook
  , libyaml
}:

stdenv.mkDerivation rec {
  pname = "camotics";
  # latest release uses hardcoded directories, master has a fix, so use master
  rev = "7901c271f472db6726738c445322cc9a3125f65c";
  version = "git-${lib.substring 0 8 rev}";

  src = fetchFromGitHub {
    owner = "CauldronDevelopmentLLC";
    repo = "CAMotics";
    inherit rev;
    sha256 = "00ggg7bj1g0v0j6chywzmf6swhbpqcx91qdpgqi23g4yiijm5az9";
  };

  nativeBuildInputs = [ scons ];

  buildInputs = [
    cbang
    qt5Full
    v8
    six
    pkgconfig
    snappy
    dxflib
    wrapQtAppsHook
    libyaml
  ];

  installFlags = "install_prefix=${placeholder "out"}";

  preBuild = ''
    export CBANG_HOME=${cbang}
    export QT5DIR=${qt5Full}
  '';

  meta = with lib; {
    description = "A 3-axis CNC GCode simulator";
    homepage = "https://camotics.org/";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ marcus7070 ];
  };
}
