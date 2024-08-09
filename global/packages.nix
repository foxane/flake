{config, pkgs, ...}:

{
  environment.packages = with pkgs; [
    clouflare-warp
    brave
    vscode-fhs

  ];

  virtualization.docker.enable = true;
}