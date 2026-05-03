# Quickstart — aurekai-nix

Nix flake and overlay for the Aurekai runtime.

## Enter Dev Shell

```bash
nix develop
```

## Run a Command

```bash
nix run .#doctor-deep
nix run .#release-gate
```

## Use the Overlay

```nix
nixpkgs.overlays = [ (import ./overlays/aurekai.nix) ];
```

## Validate

```bash
bash tests/validate-schemas.sh
bash tests/validate-scripts.sh
```
