{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, rust-overlay }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ rust-overlay.overlays.default ];
      };
      toolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
      src = pkgs.lib.cleanSource ./.;
      cargoTOML = pkgs.lib.importTOML "${src}/Cargo.toml";
      rust = pkgs.makeRustPlatform {
        cargo = toolchain;
        rustc = toolchain;
      };
    in
    {

      packages.${system}.nrf51-dongle-test = rust.buildRustPackage {
        pname = cargoTOML.package.name;
        version = cargoTOML.package.version;

        nativeBuildInputs = [ ];

        inherit src;

        cargoLock = {
          lockFile = "${src}/Cargo.lock";
        };

      };

      devShells.${system}.default = pkgs.mkShell rec {
        RUST_SRC_PATH = "${toolchain}/lib/rustlib/src/rust/library";
        #RUST_SRC_PATH = "${rustPlatform.rustLibSrc}";

        packages = [
          toolchain

          # We want the unwrapped version, "rust-analyzer" (wrapped) comes with nixpkgs' toolchain
          pkgs.rust-analyzer-unwrapped
          pkgs.clippy

          # Use probe-rs to run on hardwar
          pkgs.probe-rs-tools
        ];
      };
    };
}
