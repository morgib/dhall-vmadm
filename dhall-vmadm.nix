{ buildDhallPackage, dhall-vmadm-source }:

buildDhallPackage {
  name = "dhall-vmadm";

  code = "${dhall-vmadm-source}/package.dhall";
}
