{ mkDerivation, aeson, attoparsec, base, bytestring, dhall
, directory, fetchgit, filepath, hashable, lens, pretty-simple
, prettyprinter, prettyprinter-ansi-terminal, stdenv, text
, unordered-containers
}:
mkDerivation {
  pname = "dhall-vmadm-generate";
  version = "0.1.0.0";
  src = fetchgit {
    url = "https://github.com/morgib/dhall-vmadm-generate.git";
    sha256 = "1rakm0c5ayfzdxm2i6b8wy25rx6mfd682ix146nsjbfmvp0imrjw";
    rev = "b9863d46fee6219ac8e464a02c7e262ebca1ad48";
    fetchSubmodules = true;
  };
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson attoparsec base bytestring dhall directory filepath hashable
    lens pretty-simple prettyprinter prettyprinter-ansi-terminal text
    unordered-containers
  ];
  description = "Generate Dhall interface for SmartOS vmadm";
  license = stdenv.lib.licenses.bsd3;
}
