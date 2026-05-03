{
  description = "Aurekai Nix integration — developer shell and pipeline runners";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        aurekaiVersion = "0.8.0-alpha.4";
      in {
        devShells.default = pkgs.mkShell {
          name = "aurekai-dev";
          buildInputs = with pkgs; [
            bash
            python311
            jq
            curl
          ];
          shellHook = ''
            echo "Aurekai dev shell v${aurekaiVersion}"
            export AUREKAI_VERSION="${aurekaiVersion}"
          '';
        };

        packages.doctor-deep = pkgs.writeShellScriptBin "aurekai-doctor-deep" ''
          exec akai doctor --deep --json "$@"
        '';

        packages.manifest-verify = pkgs.writeShellScriptBin "aurekai-manifest-verify" ''
          exec akai verify --manifest "''${1:-artifact.json}" --json
        '';

        packages.release-gate = pkgs.writeShellScriptBin "aurekai-release-gate" ''
          exec akai release gate --version "${aurekaiVersion}" --json "$@"
        '';
      }
    );
}
