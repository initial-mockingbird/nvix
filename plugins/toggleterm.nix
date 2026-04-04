{ config, ... }:
let
  inherit (config.nvix.mkKey) mkKeymap wKeyObj;
in
{
  plugins = {
    toggleterm = {
      enable = true;
    };
  };
  wKeyList = [
    (wKeyObj [
      "<leader>t"
      "⌘"
      "terminal"
    ])
  ];
  keymaps = [
    (mkKeymap "n" "<leader>tc" "<cmd>ToggleTerm<cr>" "Create Terminal")
    (mkKeymap "n" "<leader>tv" "<cmd>ToggleTerm direction=vertical<cr>" "Toggle Terminal Vertical")
    (mkKeymap "n" "<leader>th" "<cmd>ToggleTerm direction=horizontal<cr>" "Toggle Terminal Horizontal")
    (mkKeymap "n" "<leader>tf" "<cmd>ToggleTerm direction=float<cr>" "Toggle Terminal Float")
  ];
}
