with import <nixpkgs> {};

mkShell {
  name = "dotnet";
  packages = [
    (with dotnetCorePackages; combinePackages [
      sdk_7_0
    ])
    mono
  ];
}
