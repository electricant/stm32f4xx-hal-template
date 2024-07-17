# shell.nix with ARM toolchain
let pkgs = import <nixpkgs> {};

in pkgs.mkShell {
  packages =  with pkgs; [
    gcc-arm-embedded
    cmake
    gnumake
    openocd
  ];
}
