# This file contains plugins that are basics or don't need their own file
{ pkgs, inputs, mkKey, ... }:
let
  inherit (mkKey) mkKeymap mkKeymap';
  mkPkgs = name: src: pkgs.vimUtils.buildVimPlugin { inherit name src; };

  # ePlugins are the plugins that are not available in nixpkgs/nixvim coming from flakes
  ePlugins = [
    (mkPkgs "color-picker" inputs.color-picker)
    (mkPkgs "moveline" inputs.moveline)
    (mkPkgs "md-pdf" inputs.md-pdf)
  ];
  # nPlugins are normally available in nixpkgs
  nPlugins = with pkgs.vimPlugins; [ 
    vim-lastplace 
    neodev-nvim 
    nvim-surround 
    windows-nvim 
    middleclass
    animation-nvim 
  ];

  maps = {
    moveline = [
      (mkKeymap' "n" "<a-k>" ":lua require('moveline').up")
      (mkKeymap' "n" "<a-j>" ":lua require('moveline').down")
      (mkKeymap' "v" "<a-k>" ":lua require('moveline').block_up")
      (mkKeymap' "v" "<a-j>" ":lua require('moveline').block_down")
    ];
    colorpicker =
      [ (mkKeymap "n" "<leader>up" "<cmd>PickColor<CR>" "Color Picker") ];
    windows =
      [ (mkKeymap "n" "<c-w>=" "<cmd>WindowsEqualize<CR>" "Equalize windows") ];
  };

in {
  # Keeping this at top so that if any plugin is removed it's respective config can be removed
  extraConfigLua = # lua
    ''
      local set= function(name)
        local ok, p = pcall(require, name)
        if ok then
          p.setup()
        end
      end
      set "windows"
      set "nvim-surround"
      set "md-pdf"
    '';

  extraPlugins = nPlugins ++ ePlugins;
  plugins = {
    # TODO: add multicursor 
    dressing.enable = true;
    neoscroll.enable = true;
    tmux-navigator.enable = true;
    todo-comments = { enable = true; };
    octo = {
      enable = true;
      settings = { suppress_missing_scope = { projects_v2 = true; }; };
    };
    colorizer = {
      #enable = true;
      enable = false;
      settings.user_default_options = {
        RGB = true;
        RRGGBB = true;
        names = true;
        RRGGBBAA = true;
        AARRGGBB = true;
        rgb_fn = true;
        hsl_fn = true;
        css = true;
        css_fn = true;
        mode = "background";
        tailwind = true;
        sass = { enable = true; }; # fff
        virtualtext = "■";
      };
    };
    fidget = {
      enable = true;
      settings = {
        progress.display.progressIcon = { pattern = "moon"; };
        notification = {
          window = {
            relative = "editor";
            winblend = 0;
            border = "none";
          };
        };
      };
    };
    auto-save = {
      enable = true;
      settings = {
        #execution_message = { enabled = false; };
        condition = # lua
          ''
            function(buf)
              local fn = vim.fn
              local utils = require("auto-save.utils.data")
              if fn.getbufvar(buf, "&buftype") ~= "" then
                return false
              end
              -- don't save for `sql` file types
              if utils.not_in(fn.getbufvar(buf, "&filetype"), { "NvimTree", "tex" }) then
                return true
              end
              return false
            end
          '';
      };
    };
  };
  keymaps = [
    (mkKeymap "n" "<leader>st" "<cmd>TodoTelescope<cr>" "Search Todo")
    (mkKeymap "n" "<leader>up" "<cmd>PickColor<cr>" "Color Picker")

    (mkKeymap "n" "<leader>umP" {
      __raw = # lua
        ''
          function()
            require("md-pdf").convert_md_to_pdf()
          end
        '';
    } "Markdown to PDF preview")
  ] ++ maps.moveline ++ maps.colorpicker ++ maps.windows;

}
