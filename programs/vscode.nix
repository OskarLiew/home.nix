{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
      ms-python.python
      sumneko.lua
      eamodio.gitlens
      njpwerner.autodocstring
      mechatroner.rainbow-csv
      yzhang.markdown-all-in-one
    ];
    userSettings = {
       "window.titleBarStyle" = "custom";
       "telemetry.telemetryLevel" = "off";
       "workbench.colorTheme" = "Everforest Dark";
       "editor.cursorSurroundingLines" = 8;

    }; 
  };
}
