{ lib, config, pkgs, ... }:

let
  cfg = config.programs.yaml-merge;

  src = pkgs.runCommand "yaml-merge-src" {} ''
    mkdir -p "$out"

    cat > "$out/go.mod" <<'EOF'
module local/yaml-merge

go 1.22

require (
  gopkg.in/yaml.v3 v3.0.1
)
EOF

    touch "$out/go.sum"

    cat > "$out/main.go" <<'EOF'
package main

import (
  "fmt"
  "os"

  "gopkg.in/yaml.v3"
)

func usage() {
  fmt.Fprintln(os.Stderr, "Usage: yaml-merge [--append-slices] <file1.yaml> <file2.yaml> ...")
  fmt.Fprintln(os.Stderr, "Merges YAML left-to-right with deep map merge; later files override earlier ones.")
  os.Exit(2)
}

func deepMerge(dst, src map[string]any, appendSlices bool) map[string]any {
  for k, sv := range src {
    if dv, ok := dst[k]; ok {
      // map + map => recurse
      dm, dok := dv.(map[string]any)
      sm, sok := sv.(map[string]any)
      if dok && sok {
        dst[k] = deepMerge(dm, sm, appendSlices)
        continue
      }

      // slice + slice => append or override
      ds, dok := dv.([]any)
      ss, sok := sv.([]any)
      if dok && sok && appendSlices {
        dst[k] = append(ds, ss...)
        continue
      }

      // otherwise: override
      dst[k] = sv
    } else {
      dst[k] = sv
    }
  }
  return dst
}

func main() {
  args := os.Args[1:]
  if len(args) == 0 {
    usage()
  }

  appendSlices := false
  files := make([]string, 0, len(args))

  for _, a := range args {
    switch a {
    case "--help", "-h":
      usage()
    case "--append-slices":
      appendSlices = true
    default:
      // treat everything else as a filename
      files = append(files, a)
    }
  }

  if len(files) == 0 {
    usage()
  }

  merged := map[string]any{}

  for i, file := range files {
    b, err := os.ReadFile(file)
    if err != nil {
      fmt.Fprintf(os.Stderr, "yaml-merge: unable to read file %d (%s): %v\n", i, file, err)
      os.Exit(1)
    }

    var m map[string]any
    if err := yaml.Unmarshal(b, &m); err != nil {
      fmt.Fprintf(os.Stderr, "yaml-merge: unable to unmarshal file %d (%s): %v\n", i, file, err)
      os.Exit(1)
    }

    merged = deepMerge(merged, m, appendSlices)
  }

  out, err := yaml.Marshal(merged)
  if err != nil {
    fmt.Fprintf(os.Stderr, "yaml-merge: unable to marshal output: %v\n", err)
    os.Exit(1)
  }

  os.Stdout.Write(out)
}
EOF
  '';

  pkg = pkgs.buildGoModule {
    pname = "yaml-merge";
    version = "0.1.0";
    inherit src;

    vendorHash = cfg.vendorHash;
    subPackages = [ "." ];

    env = {
      CGO_ENABLED = "0";
    };

    ldflags = [ "-s" "-w" ];
  };
in
{
  options.programs.yaml-merge = {
    enable = lib.mkEnableOption "yaml-merge CLI (local Go build)";

    vendorHash = lib.mkOption {
      type = lib.types.str;
      default = lib.fakeHash;
      description = "Fixed-output hash for Go deps (vendorHash). First build tells you the right value.";
    };

    addToPath = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to add yaml-merge to the system PATH.";
    };

    package = lib.mkOption {
      type = lib.types.package;
      readOnly = true;
      description = "The built yaml-merge package.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.yaml-merge.package = pkg;

    environment.systemPackages = lib.mkIf cfg.addToPath [
      cfg.package
    ];
  };
}