{ 
  lib
  , mkDerivation
  , fetchFromGitHub
  , scons
  , cbang
  , qt5Full
  , v8
  , six
  , pkgconfig
}:

mkDerivation rec {
  pname = "camotics";
  version = "v1.2.0";

  src = fetchFromGitHub {
    owner = "CauldronDevelopmentLLC";
    repo = "CAMotics";
    rev = version;
    sha256 = "1f84cv72ydcanjfm5i011vwjn1q4wscynpydr8hihzyw07fr7y8a";
  };

  nativeBuildInputs = [ scons ];

  buildInputs = [
    cbang
    qt5Full
    v8
    six
    pkgconfig
  ];

  preBuild = ''
    export CBANG_HOME=${cbang}/complete
  '';

  meta = with lib; {
    description = "A 3-axis CNC GCode simulator";
    homepage = "https://camotics.org/";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ marcus7070 ];
  };
}
