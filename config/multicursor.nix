{ mkKey, ... }:
let inherit (mkKey) mkKeymap;
in {
  plugins.multicursors = {
    enable = true;
  };
  keymaps = [
      ];
}
