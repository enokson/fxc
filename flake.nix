{
  description = "A simple program to get the only 'true' source the forex exchange (fx) rate bewteen the USD and Сомони (Tajikistan Somoni.)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    packages.x86_64-linux.fxc = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
      name = "fxc";
      src = ./src;
      installPhase = ''
        mkdir -p $out/bin
        cp $src/main.sh $out/bin/fxc
      '';
    };
    packages.x86_64-linux.default = self.packages.x86_64-linux.fxc;
  };
}
