{ 
  stdenv
  , lib
  , fetchFromGitHub
  , scons
  , openssl
  , v8_3_14_5
}:

stdenv.mkDerivation rec {
  pname = "cbang";
  version = "1.3.3";

  src = fetchFromGitHub {
    owner = "CauldronDevelopmentLLC";
    repo = "cbang";
    rev = version;
    sha256 = "1g5xfqx1qz86ik2p0vf91pig7ikz3n61nqs3gp66ksvgawbfkjy7";
  };

  nativeBuildInputs = [
    scons
  ];

  buildInputs = [
    openssl
    v8_3_14_5
  ];

  postInstall = ''
    mkdir $out/complete
    cp -r ./* $out/complete
  '';

  meta = with lib; {
    description = "C! (cbang) is a library of cross-platform C++ utilities";
    homepage = "http://cbang.org/";
    license = licenses.lgpl21;
    maintainers = with maintainers; [ marcus7070 ];
  };

}
