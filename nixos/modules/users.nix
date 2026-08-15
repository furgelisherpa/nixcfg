{pkgs, ...}: {
  # Primary user account, with sudo (wheel) and network management rights
  users.users.pstivy = {
    isNormalUser = true;
    description = "pstivy";
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
