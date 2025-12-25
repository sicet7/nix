pkgs.buildEnv {
  name = "node22-env";
  paths = [
    pkgs.nodejs_22
  ];
}