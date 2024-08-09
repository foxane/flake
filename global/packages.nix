{config, pkgs, ...}:

{
  environment.packages = with pkgs; [
    clouflare-warp
    brave
    vscode-fhs
    spotube
    discord
    gh
  ];

  virtualization.docker.enable = true;
}