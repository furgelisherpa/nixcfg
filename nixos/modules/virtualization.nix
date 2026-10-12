{pkgs, ...}: {
  # --- module: virtualization.nix -----------------------------------------
  virtualisation = {
    docker = {
      enable = true;

      # Periodic cleanup of unused docker images/containers/networks so the
      # docker storage dir doesn't grow unbounded.
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
      };
    };
  };

  # GUI front-end for libvirt VMs (Virtual Machine Manager).
  programs.virt-manager.enable = true;
  users.users.pstivy = {
    extraGroups = ["docker" "libvirtd"];
  };
}
