{ pkgs, inputs, mkKey, ... }:
let inherit (mkKey) mkKeymap;
in {
  plugins.auto-session = {
    enable = true;
  
  };
  keymaps = [
    (mkKeymap "n" "<leader>S." "<cmd>SessionRestore<CR>"
      "Last Session")
    (mkKeymap "n" "<leader>Sl" "<cmd>SessionSearch<CR>"
      "List Session")
    (mkKeymap "n" "<leader>Ss" "<cmd>SessionSave<CR>"
      "Save Session")
    (mkKeymap "n" "<leader>SD" "<cmd>SessionDelete<CR>"
      "Delete sessions")
  ];
}
