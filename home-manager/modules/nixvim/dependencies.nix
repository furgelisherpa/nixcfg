{...}: {
  # External CLI tools required by various nixvim plugins. These are the
  # runtime dependencies that plugins shell out to (e.g. ctags for tagbars,
  # imagemagick for image previews, tree-sitter CLI).
  programs.nixvim.dependencies = {
    ctags.enable = true;
    imagemagick.enable = true;
    tree-sitter.enable = true;
  };
}
