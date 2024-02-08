{ config, pkgs, inputs, ... }:
{
    imports = [
        inputs.nixvim.homeManagerModules.nixvim
    ];
  # programs.neovim = {
  #   enable = true;
  #   vimAlias = true;
  #   vimdiffAlias = true;
  #   defaultEditor = true;
  # };

  nixpkgs = {
      overlays = [
        (final: prev: {
            vimPlugins = prev.vimPlugins // {
                everforest-nvim = prev.vimUtils.buildVimPlugin {
                    name = "everforest-nvim";
                    src = inputs.everforest-nvim;
                    dontunpack = true;
                };
            };
         })
      ];
  };


  programs.nixvim = {
      enable = true;
      plugins = {
          tmux-navigator.enable = true;
      };
      extraPlugins = with pkgs.vimPlugins; [
        {
            plugin = everforest;
            config = ''
                if has('termguicolors')
                  set termguicolors
                endif
                set background=dark
                let g:everforest_background = 'hard'
                let g:everforest_transparent_background = '2'
                colorscheme everforest
            '';
        }
      ];
  };


  xdg.configFile = {
    "snippets".source = ../config/snippets;
  };
}

