self: super: {
  python = super.python.override {
    packageOverrides = python-self: python-super: {
      gyp = python-super.callPackage ./gyp { };
    };
  };
  v8_3_14_5 = super.callPackage ./v8 {
    inherit (self.pythonPackages) python gyp;
    cctools = self.darwin.cctools;
    stdenv = self.gcc5Stdenv; 
  };
  cbang = super.callPackage ./cbang { };
  camotics = super.libsForQt5.callPackage ./camotics { 
    inherit (self.pythonPackages) six; 
    stdenv = self.gcc6Stdenv; 
  };
}
