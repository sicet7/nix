with import <nixpkgs> {};

mkShell {
  name = "dotnet";
  packages = [
    (with dotnetCorePackages; combinePackages [
      sdk_6_0
    ])
    mono
  ];
}
