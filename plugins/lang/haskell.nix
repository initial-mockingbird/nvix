{ pkgs, ... }:
{
  plugins.lsp.servers.hls = {
    enable = true;
    installGhc = false;
    packageFallback = true;
  };

  plugins.haskell-tools = {
    enable = true;

  };

  extraFiles."after/ftplugin/haskell.lua" = {
    text = ''
      local ht = require('haskell-tools')
      local bufnr = vim.api.nvim_get_current_buf()
      function mkOpts(desc)
        return { noremap = true, silent = true, buffer = bufnr, desc = desc,}
      end
      -- haskell-language-server relies heavily on codeLenses,
      -- so auto-refresh (see advanced configuration) is enabled by default
      vim.keymap.set('n', '<leader>rl', vim.lsp.codelens.run, mkOpts('Haskell Run Codelens') )
      -- Hoogle search for the type signature of the definition under the cursor
      vim.keymap.set('n', '<leader>xs', ht.hoogle.hoogle_signature, mkOpts('Hoogle Search Word'))
      -- Evaluate all code snippets
      vim.keymap.set('n', '<leader>ea', ht.lsp.buf_eval_all, mkOpts('Eval all code snippets'))
      -- Toggle a GHCi repl for the current package
      vim.keymap.set('n', '<leader>rr', ht.repl.toggle, mkOpts('GHCI current package'))
      -- Toggle a GHCi repl for the current buffer
      vim.keymap.set('n', '<leader>rf', function()
        ht.repl.toggle(vim.api.nvim_buf_get_name(0))
      end, mkOpts('GHCI for current buffer'))
      vim.keymap.set('n', '<leader>rq', ht.repl.quit, mkOpts('Quit repl'))
    '';
  };

}
