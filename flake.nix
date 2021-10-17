{
  description = "Generate Dhall schema for vmadm";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable"; };

  outputs = { self, nixpkgs }:
    let
      pkgsSystem = system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        };
    in {
      packages.x86_64-linux = let pkgs = pkgsSystem "x86_64-linux";
      in {
        inherit (pkgs) vmadm-proptable dhall-vmadm-generate dhall-vmadm-source;
      };

      overlay = import ./overlay.nix;

      devShells.x86_64-linux = let pkgs = pkgsSystem "x86_64-linux";
      in {
        dhall-vmadm-generate = pkgs.haskellPackages.shellFor {
          packages = p: with p; [ dhall-vmadm-generate ];
          buildInputs = with pkgs.haskellPackages; [ cabal-install ghc ];
        };
      };

    };
}

