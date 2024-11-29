{ pkgs, ...}:
{
  extraConfigLua = 
    ''
      vim.cmd([[
      let g:coqtail_map_prefix = "<leader>;" 
      ]])
    '';
  extraPlugins = with pkgs.vimPlugins; [
    Coqtail
  ];


}
