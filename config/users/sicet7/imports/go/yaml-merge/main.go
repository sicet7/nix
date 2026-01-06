package main

import (
	"fmt"
	"os"

	"gopkg.in/yaml.v3"
)

func usage() {
	fmt.Fprintln(os.Stderr, "Usage: yaml-merge [--append-slices] <file1.yaml> <file2.yaml> ...")
	fmt.Fprintln(os.Stderr, "Deep-merges YAML maps left-to-right; later files override earlier ones.")
	fmt.Fprintln(os.Stderr, "  --append-slices   If both values are YAML sequences, append instead of overriding.")
	os.Exit(2)
}

func deepMerge(dst, src map[string]any, appendSlices bool) map[string]any {
	for k, sv := range src {
		if dv, ok := dst[k]; ok {
			dm, dok := dv.(map[string]any)
			sm, sok := sv.(map[string]any)
			if dok && sok {
				dst[k] = deepMerge(dm, sm, appendSlices)
				continue
			}

			ds, dok := dv.([]any)
			ss, sok := sv.([]any)
			if appendSlices && dok && sok {
				dst[k] = append(ds, ss...)
				continue
			}

			dst[k] = sv
		} else {
			dst[k] = sv
		}
	}
	return dst
}

func main() {
	args := os.Args[1:]
	if len(args) < 1 {
		usage()
	}

	appendSlices := false
	files := make([]string, 0, len(args))

	for _, a := range args {
		switch a {
		case "-h", "--help":
			usage()
		case "--append-slices":
			appendSlices = true
		default:
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
