{...}: {
  # Load nixvim option groups; order roughly follows startup dependency
  imports = [
    ./dependencies.nix
    ./options.nix
    ./keymaps
    ./autocmds.nix
    ./plugins.nix
    ./lsp.nix
    ./terminal.nix
    ./formatting.nix
    ./lint.nix
    ./telescope.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
