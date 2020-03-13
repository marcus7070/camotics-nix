{ 
  stdenv
  , lib
  , fetchFromGitHub
  , scons
  , openssl
  , v8_3_14_5
  , rsync
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
    rsync
  ];

  buildInputs = [
    openssl
    v8_3_14_5
  ];

  # dev wants to access everything here in the camotics program
  # there is way too much non-standard stuff here to do a proper install, just copy the lot to store.
  installPhase = ''
    mkdir $out/complete
    rsync -r --exclude=*.pyc ./ $out/
  '';

  meta = with lib; {
    description = "C! (cbang) is a library of cross-platform C++ utilities";
    homepage = "http://cbang.org/";
    license = licenses.lgpl21;
    maintainers = with maintainers; [ marcus7070 ];
  };

}
