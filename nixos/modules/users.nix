{pkgs, ...}: {
  # --- module: users.nix ---------------------------------------------------

  users.users.pstivy = {
    isNormalUser = true;
    description = "pstivy";
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
