{
  buildPythonPackage
  , fetchgit
  , stdenv
  , isPy3k
  , lib
}: 

buildPythonPackage rec {
  name = "gyp-${version}";
  version = "2015-06-11";

  src = fetchgit {
    url = "https://chromium.googlesource.com/external/gyp.git";
    rev = "fdc7b812f99e48c00e9a487bd56751bbeae07043";
    sha256 = "1imgxsl4mr1662vsj2mlnpvvrbz71yk00w8p85vi5bkgmc6awgiz";
  };

  prePatch = lib.optionals stdenv.isDarwin ''
    sed -i 's/raise.*No Xcode or CLT version detected.*/version = "7.0.0"/' pylib/gyp/xcode_emulation.py
  '';

  patches = lib.optionals stdenv.isDarwin [
    ./no-darwin-cflags.patch
    ./no-xcode.patch
  ];

  disabled = isPy3k;

  meta = {
    description = "A tool to generate native build files";
    homepage = "https://chromium.googlesource.com/external/gyp/+/master/README.md";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ marcus7070 ];
    platforms = lib.platforms.all;
  };
}
