{...}: {
  imports = [
    ./general.nix
    ./tabs.nix
    ./buffers.nix
    ./folds-commands.nix
  ];

  # Groups themselves are declared next to their keymaps throughout
  # the config; this just enables which-key and seeds the spec list.
  programs.nixvim.plugins.which-key = {
    enable = true;
    settings = {
      preset = "classic";
      delay = 200;
      spec = [];
    };
  };
}
