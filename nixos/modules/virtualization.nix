{pkgs, ...}: {
  virtualisation = {
    docker = {
      enable = true;

      # Weekly cleanup of unused docker images/containers
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        # Enable virtual TPM support for guest VMs
        swtpm.enable = true;
      };
    };
  };

  # GUI front-end for libvirt VMs
  programs.virt-manager.enable = true;

  # Let pstivy run docker/libvirt without sudo
  users.users.pstivy = {
    extraGroups = ["docker" "libvirtd"];
  };
}
