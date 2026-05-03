# overlays/aurekai.nix — Aurekai Nix overlay
final: prev: {
  aurekai = {
    version = "0.8.0-alpha.4";
    doctor-deep = prev.writeShellScriptBin "aurekai-doctor-deep" ''
      exec ${prev.bash}/bin/bash -c "akai doctor --deep --json"
    '';
    release-gate = prev.writeShellScriptBin "aurekai-release-gate" ''
      exec ${prev.bash}/bin/bash -c "akai release gate --version 0.8.0-alpha.4 --json"
    '';
  };
}
