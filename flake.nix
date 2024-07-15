{
  description = "A simple program to get the only 'offical' source the forex exchange (fx) rate bewteen the USD and Сомони (Tajikistan Somoni.)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let 
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages."x86_64-linux".fxc = pkgs.stdenv.mkDerivation {
        name = "fxc";
        src = ./src;
        installPhase = ''
          mkdir -p $out/bin
          cp $src/main.sh $out/bin/fxc
        '';
    };
    packages."x86_64-linux".default = self.packages."x86_64-linux".fxc;
    devShells."x86_64-linux".default = pkgs.mkShell {
      buildInputs = with pkgs; [
        rust-analyzer # LSP Server
        rustfmt       # Formatter
        clippy        # Linter
      ];
    };
  };
}
