{ stdenv, vmadm-proptable, dhall-vmadm-generate }:

stdenv.mkDerivation {
  name = "dhall-vmadm";

  buildInputs = [ dhall-vmadm-generate ];

  phases = [ "buildPhase" "installPhase" ];

  buildPhase = ''
    dhall-vmadm-generate "${vmadm-proptable}/proptable.json"
    '';

  installPhase = ''
    mkdir -p $out
    cp -r build/* $out
    '';

}


