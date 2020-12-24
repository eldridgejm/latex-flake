{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/20.09;

  outputs = { self, nixpkgs }: 
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in
      {
        defaultPackage = forAllSystems (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
            pkgs.texlive.combine {
                inherit (pkgs.texlive)
                scheme-full;
              }
        );
      };
}
