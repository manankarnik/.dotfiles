let
  pkgs = import
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/f597e7e9fcf37d8ed14a12835ede0a7d362314bd.tar.gz";
    })
    {
      config.allowInsecure = true;
    };
  nodejs_12 = pkgs.nodejs-12_x;
in
pkgs.mkShell rec {

  name = "nodejs_12";
  buildInputs = with pkgs; [
    nodejs_12
  ];
}
