{ stdenv, fetchFromGitHub, nodejs }:

stdenv.mkDerivation {
  name = "vmadm-proptable";

  src = fetchFromGitHub {
    owner  = "joyent";
    repo   = "smartos-live";
    rev = "3fe917816d3fee29efb121bb8f8d1cb48ef4d1d2";
    sha256 = "12la8bxxssd9h714i9vhsibv6bdlqd0j9fz625ca050bch2rnljr";
  };

  buildInputs = [ nodejs ];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  buildPhase = ''
    cat > proptable_json.js <<EOF
    const proptable = require ('./src/vm/node_modules/proptable');
    console.log (JSON.stringify (proptable));
    EOF

    node proptable_json.js > proptable.json
    '';

  installPhase = ''
    mkdir -p $out
    cp proptable.json $out
    '';

}


