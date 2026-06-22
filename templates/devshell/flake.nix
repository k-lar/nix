{
  description = "Development shell";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

  outputs = { self, nixpkgs }:
  let
    systems = [
      "x86_64-linux"
      "aarch64-darwin"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;

  in {
    devShells = forAllSystems (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        default = pkgs.mkShell {
          packages = with pkgs; [
            # Languages
            # go
            # nodejs
            # python3
            # rustc
            # cargo

            # Tools
            # git
            # gnumake
            # just

            # Databases
            # mariadb
            # postgresql

            # Containers
            # docker
            # docker-compose

            # Misc
            # jq
            # sqlite
          ];

          shellHook = ''
            echo "Development shell ready"
          '';
        };
      });
  };
}
