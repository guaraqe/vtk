{ mkDerivation, attoparsec, base, bytestring, lens, linear, permute
, spool, stdenv, vector
}:
mkDerivation {
  pname = "vtk";
  version = "0.1.0";
  src = ./.;
  libraryHaskellDepends = [
    attoparsec base bytestring lens linear permute spool vector
  ];
  description = "Synopsis";
  license = stdenv.lib.licenses.gpl3;
}
