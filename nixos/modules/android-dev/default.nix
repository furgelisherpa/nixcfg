{...}: {
  imports = [./config.nix];

  programs.android-dev = {
    enable = true;
    user = "pstivy";
    enableAdb = true;
    addToKvmGroup = true;
  };
}
