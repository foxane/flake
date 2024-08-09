{config, pkgs, ...}:

{
  environment.packages = with pkgs; [
    clouflare-warp
    brave
    vscode-fhs
    spotube
    discord
    gh
    vim
    wget
    curl
    git
  ];

  virtualization.docker.enable = true;

  programs= {

    git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
        user.name = "foxane";
        user.email = "65512187+foxane@users.noreply.github.com"
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };

  };
}