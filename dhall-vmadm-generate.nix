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
    sha256 = "1qqmarkjibrc6qd679z173c15abdpzf4l45gyf20pm497iw94r2d";
    rev = "5658bd5b44bac2a0ecef58566b822f1ba34cb1af";
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
