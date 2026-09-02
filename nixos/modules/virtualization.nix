{pkgs, ...}: {
  # --- module: virtualization.nix -----------------------------------------
  # Owns Docker + QEMU/KVM/libvirt virtualisation and the GUI/group access
  # needed to drive it.

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
        package = pkgs.qemu_kvm; # KVM-accelerated QEMU
      };
    };
  };

  # GUI front-end for libvirt VMs (Virtual Machine Manager).
  programs.virt-manager.enable = true;

  # Let pstivy run docker/libvirt commands without sudo by adding them to the
  # respective group. (Account base groups live in users.nix.)
  users.users.pstivy = {
    extraGroups = ["docker" "libvirtd"];
  };
}
