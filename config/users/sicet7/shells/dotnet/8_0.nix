with import <nixpkgs> {};

mkShell {
  name = "dotnet";
  packages = [
    (with dotnetCorePackages; combinePackages [
      sdk_8_0
    ])
    mono
  ];
}
