{ pkgs, mkKey, ...}:
let inherit (mkKey) mkKeymap;
in {
  extraConfigLua = 
    ''
      vim.cmd([[
      let g:coqtail_nomap  = 1
      let g:coqtail_noimap = 1 
      ]])
      '';

  extraPlugins = with pkgs.vimPlugins; [
    Coqtail
  ];
  
  keymaps = [
    (mkKeymap "n" "<leader>vc" "<cmd>CoqStart<cr>"       "Launch Coqtail in current buffer")
    (mkKeymap "n" "<leader>vq" "<cmd>CoqStop<cr>"        "Quit Coqtail in current buffer")
    (mkKeymap "n" "<leader>vj" "<cmd>1CoqNext<cr>"       "Send the next sentence to Coq")
    (mkKeymap "n" "<leader>vT" "<cmd>CoqToTop<cr>"       "Rewind to the beginning of the file")
    (mkKeymap "n" "<leader>vG" "<cmd>CoqJumpToEnd<cr>"   "Move the cursor to the end of the checked region")
    (mkKeymap "n" "<leader>vE" "<cmd>CoqJumpToError<cr>" "Move the cursor to the start of the error region")
    (mkKeymap "n" "<leader>vh" "<cmd>Coq Check <arg><cr>" "Show type")
  ];

}
