{pkgs, ...}: {
  # --- module: users.nix ---------------------------------------------------
  # Owns the primary user account and its system-level groups/privileges.

  # Primary user account.
  users.users.pstivy = {
    isNormalUser = true;
    description = "pstivy";
    # wheel = sudo; networkmanager = allow `nmcli`-based network control.
    # (docker/libvirtd are added in virtualization.nix so this module stays
    # focused on account basics.)
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.zsh;
  };

  # Required for the `shell = pkgs.zsh` above; the user's interactive zsh
  # config lives in home-manager/modules/zsh.nix.
  programs.zsh.enable = true;
}
