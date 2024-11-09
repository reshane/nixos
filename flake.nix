{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, ... }@inputs:
        let
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in
            {
            devShells.x86_64-linux.default =
                pkgs.mkShell
                {
                    nativeBuildInputs = with pkgs; [
                        pkgs.lld
                        pkgs.cargo
                        pkgs.rustc
                        pkgs.openssl
                        pkgs.pkg-config
                        pkgs.trunk
                    ];
                    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
                };
            nixosConfigurations = {
                circus-ridge = nixpkgs.lib.nixosSystem {
                    specialArgs = {inherit inputs;};
                    modules = [
                        ./hosts/circus-ridge/configuration.nix
                    ];
                };
            };
        };
}
