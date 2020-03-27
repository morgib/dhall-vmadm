self: super:

# `properExtend` comes from comments on https://github.com/NixOS/nixpkgs/issues/26561
# by dhess, and ElvishJerrico
# https://github.com/dhess/dhess-lib-nix/blob/f3f9660c4d86eabee40fd587b15c3535936857a3/overlays/haskell/lib.nix

let
  properExtend = hp: f: hp.override (oldArgs: {
    overrides =
    super.lib.composeExtensions (oldArgs.overrides or (_: _: {}))
      f;
  });

  haskellExtend = hpSelf: hpSuper: {
    dhall-vmadm-generate = hpSuper.callPackage ./dhall-vmadm-generate.nix {};

    dhall = hpSuper.dhall_1_29_0;
  };

  dhallExtend = dpSelf: dpSuper: {
    dhall-vmadm = dpSuper.callPackage ./dhall-vmadm.nix { };
  };

in

{ 
  vmadm-proptable = super.callPackage ./vmadm-proptable.nix { };

  haskellPackages = properExtend super.haskellPackages haskellExtend;

  haskell = (super.haskell or {}) // {
    lib = (super.haskell.lib or {}) // {
      inherit properExtend;
    };
  };

  dhall-vmadm-generate = self.haskellPackages.dhall-vmadm-generate;
  dhall-vmadm-source = self.callPackage ./dhall-vmadm-source.nix { };
  dhallPackages = super.lib.fix' (super.lib.extends dhallExtend
                   (self: super.dhallPackages // { callPackage = super.newScope self; }));
}
