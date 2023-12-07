{ upkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = upkgs.vscode;
    extensions = with upkgs.vscode-extensions;
      [
        # vscodevim.vim  # I need to fix other keybindings first
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-containers
        ms-azuretools.vscode-docker
        ms-python.python
        ms-python.vscode-pylance
        ms-python.black-formatter
        sumneko.lua
        eamodio.gitlens
        njpwerner.autodocstring
        mechatroner.rainbow-csv
        yzhang.markdown-all-in-one
        davidanson.vscode-markdownlint
        rust-lang.rust-analyzer
        redhat.vscode-yaml
      ] ++ upkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # {
        #   name = "everforest";
        #   publisher = "sainnhe";
        #   version = "0.3.0";
        #   sha256 = "";
        # }
      ];
    mutableExtensionsDir = false;
    enableUpdateCheck = false;
    userSettings = {
      "window.titleBarStyle" = "custom";
      "telemetry.telemetryLevel" = "off";
      "workbench.colorTheme" = "Everforest Dark";
      "editor.cursorSurroundingLines" = 8;
      "editor.fontFamily" = "Fira Code";
      "notebook.lineNumbers" = "on";
      "editor.lineNumbers" = "relative";
      "vim.normalModeKeyBindings" = [
        {
          "before" = [ "<C-u>" ];
          "after" = [ "<C-u>" "z" "z" ];
        }
        {
          "before" = [ "<C-d>" ];
          "after" = [ "<C-d>" "z" "z" ];
        }
        {
          "before" = [ "<leader>" "/" ];
          "commands" = [ "editor.action.commentLine" ];
        }
      ];
      "[python]" = { "editor.defaultFormatter" = "ms-python.black-formatter"; };
      "[yaml]" = { "editor.defaultFormatter" = "redhat.vscode-yaml"; };
      "[markdown]" = {
        "editor.defaultFormatter" = "davidanson.vscode-markdownlint";
      };
    };
  };
}
