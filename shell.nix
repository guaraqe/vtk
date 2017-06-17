with (import <nixpkgs> {});

(haskellPackages.callPackage ./. {
  permute = haskellPackages.callPackage ./deps/permute-1.0 {};
}).env
