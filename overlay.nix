self: super:
let
  haskellOverlay = hpSelf: hpSuper: {
    dhall-vmadm-generate = hpSuper.callPackage ./dhall-vmadm-generate {};

    #dhall = hpSuper.dhall_1_29_0;
  };

  dhallOverlay = dpSelf: dpSuper: {
    dhall-vmadm = dpSuper.callPackage ./dhall-vmadm.nix { };
  };
in
{
  # Method of overriding copied from
  # https://github.com/NixOS/nixpkgs/issues/101580#issuecomment-716086458
  haskell = super.haskell // {
    packages = super.haskell.packages // {
      ghc8107 =
        (
          super.haskell.packages.ghc8107.override {
            ghc = super.haskell.compiler.ghc8107.overrideAttrs (
              prev: {
                preConfigure = (prev.preConfigure or "") +
                  ''
                    sed -ie 's/^.*printf.*HAVE_FLOCK/#\0/' libraries/base/configure
                    sed -ie 's/^.*printf.*HAVE_OFD_LOCKING/#\0/' libraries/base/configure
                  '';
              }
            );
          }
        ).extend haskellOverlay;
    };
  };
  vmadm-proptable = super.callPackage ./vmadm-proptable.nix { };
  dhall-vmadm-generate = self.haskellPackages.dhall-vmadm-generate;
  dhall-vmadm-source = self.callPackage ./dhall-vmadm-source.nix { };
  dhallPackages = super.lib.fix' (super.lib.extends dhallOverlay
                   (self: super.dhallPackages // { callPackage = super.newScope self; }));
}
