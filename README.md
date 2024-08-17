# nrf51 dongle test

This is a test for programming the nRF51 dongle using Rust, probe-rs and Nix package manager.
The repo is tested in Linux and Windows(using WSL).
Much inspired by the [embassy example nrf51 project](https://github.com/embassy-rs/embassy/tree/main/examples/nrf51).

The following technologies are used:
- [Rust](https://www.rust-lang.org/) programming language
- [Embassy](https://github.com/embassy-rs/embassy) embedded framework
- [Probe-rs](https://probe.rs/) for running the program on chip
- [Nix](https://nixos.org/) package manager for installing dependencies, including rust and probe-rs

## Development

### Linux / NixOS

Enter the development environment by running:

``` shell
nix develop
```

From there is should be as simple as running `cargo run` with the nrf51 dongle connected.
Remember to add the relevant udev rules for your programming device.
More info can be read on the probe-rs project page.

### Windows / WSL

By using `usbipd` one can connect USB devices to a WSL distro.
More detailed instructions can be found [here](https://learn.microsoft.com/en-us/windows/wsl/connect-usb).
