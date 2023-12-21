{ upkgs, lib, ... }: {
  programs.vscode = {
    enable = true;
    package = upkgs.vscode;
    extensions = with upkgs.vscode-extensions;
      [
        vscodevim.vim
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
        vadimcn.vscode-lldb
      ] ++ upkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "everforest";
          publisher = "sainnhe";
          version = "0.3.0";
          sha256 = "sha256-nZirzVvM160ZTpBLTimL2X35sIGy5j2LQOok7a2Yc7U=";
        }
        {
          name = "everforest-custom";
          publisher = "djprophet";
          version = "0.0.1";
          sha256 = "sha256-3Me7vs+dP+oUhJOjX0eRxflLVJiNTbRaIfvbmv6mzj0=";
        }
      ];
    mutableExtensionsDir = false;
    enableUpdateCheck = false;
    userSettings = {
      "window.titleBarStyle" = "custom";
      "telemetry.telemetryLevel" = "off";
      "workbench.colorTheme" = "Everforest Custom";
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
      "vim.whichwrap" = "b,s,h,l,w,e,W,E";
      "[python]" = { "editor.defaultFormatter" = "ms-python.black-formatter"; };
      "[yaml]" = { "editor.defaultFormatter" = "redhat.vscode-yaml"; };
      "[markdown]" = {
        "editor.defaultFormatter" = "davidanson.vscode-markdownlint";
      };
    };
    keybindings = [
      {
        key = "ctrl+p";
        command = "-extension.vim_ctrl+p";
        when = "editorTextFocus && vim.active && vim.use<C-p> && !inDebugRepl || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'CommandlineInProgress' || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'SearchInProgressMode'";
      }
      {
        key = "ctrl+n";
        command = "-extension.vim_ctrl+n";
        when = "editorTextFocus && vim.active && vim.use<C-n> && !inDebugRepl || vim.active && vim.use<C-n> && !inDebugRepl && vim.mode == 'CommandlineInProgress' || vim.active && vim.use<C-n> && !inDebugRepl && vim.mode == 'SearchInProgressMode'";
      }
      {
        key = "ctrl+c";
        command = "-extension.vim_ctrl+c";
        when = "editorTextFocus && vim.active && vim.overrideCtrlC && vim.use<C-c> && !inDebugRepl";
      }
      {
        key = "ctrl+v";
        command = "-extension.vim_ctrl+v";
        when = "editorTextFocus && vim.active && vim.use<C-v> && !inDebugRepl";
      }
      {
        key = "alt+j";
        command = "terminal.focus";
        when = "!terminalFocus";
      }
      {
        key = "alt+j";
        command = "workbench.action.focusActiveEditorGroup";
        when = "terminalFocus";
      }
      {
        key = "ctrl+n";
        command = "selectNextSuggestion";
        when = "suggestWidgetVisible";
      }
      {
        key = "ctrl+p";
        command = "selectPrevSuggestion";
        when = "suggestWidgetVisible";
      }
      {
        key = "ctrl+p";
        command = "workbench.action.quickOpen";
        when = "!(inQuickOpen || suggestWidgetVisible)";
      }
      {
        key = "ctrl+p";
        command = "-workbench.action.quickOpen";
      }
      {
        key = "ctrl+n";
        command = "-workbench.action.files.newUntitledFile";
      }
      {
        key = "ctrl+n";
        command = "workbench.action.quickOpenSelectNext";
        when = "inQuickOpen";
      }
      {
        key = "ctrl+p";
        command = "workbench.action.quickOpenSelectPrevious";
        when = "inQuickOpen";
      }
      {
        key = "ctrl+n";
        command = "workbench.action.terminal.new";
        when = "terminalFocus && (terminalProcessSupported || terminalWebExtensionContributedProfile)";
      }
      {
        key = "ctrl+j";
        command = "workbench.action.terminal.focusNext";
        when = "terminalFocus && terminalHasBeenCreated && !terminalEditorFocus || terminalFocus && terminalProcessSupported && !terminalEditorFocus";
      }
      {
        key = "ctrl+k";
        command = "workbench.action.terminal.focusPrevious";
        when = "terminalFocus && terminalHasBeenCreated && !terminalEditorFocus || terminalFocus && terminalProcessSupported && !terminalEditorFocus";
      }
      {
        key = "ctrl+h";
        command = "workbench.action.focusLeftGroup";
        when = "editorTextFocus && vim.active && vim.mode != 'Insert'";
      }
      {
        key = "ctrl+l";
        command = "workbench.action.focusRightGroup";
        when = "editorTextFocus && vim.active && vim.mode != 'Insert'";
      }
      {
        key = "ctrl+k";
        command = "workbench.action.focusAboveGroup";
        when = "editorTextFocus && vim.active && vim.mode != 'Insert'";
      }
      {
        key = "ctrl+j";
        command = "workbench.action.focusBelowGroup";
        when = "editorTextFocus && vim.active && vim.mode != 'Insert'";
      }
      {
        key = "shift+k";
        command = "editor.action.showHover";
        when = "editorTextFocus";
      }
    ];
    languageSnippets = {
      python = builtins.fromJSON (builtins.readFile ../config/snippets/python.json);
    };
  };
}
