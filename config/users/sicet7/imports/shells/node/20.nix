pkgs.buildEnv {
  name = "node20-env";
  paths = [
    pkgs.nodejs_20
  ];
}