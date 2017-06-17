{ mkDerivation, base, mtl, stdenv }:
mkDerivation {
  pname = "permute";
  version = "1.0";
  src = ./.;
  libraryHaskellDepends = [ base mtl ];
  description = "Generalised permutation parser combinator";
  license = stdenv.lib.licenses.bsd3;
}
