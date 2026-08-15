{...}: {
  # External CLI tools required by various nixvim plugins
  programs.nixvim.dependencies = {
    ctags.enable = true;
    imagemagick.enable = true;
    tree-sitter.enable = true;
  };
}
