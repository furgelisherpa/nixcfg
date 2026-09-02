{...}: {
  # --- module: configuration.nix -----------------------------------------
  # Top-level NixOS entry point. Imports the per-concern system modules and
  # holds the global settings that must not live in a sub-module (stateVersion).
  # Add new system concerns here as an import, mirroring how home-manager/nix
  # groups its own modules in home-manager/home.nix.

  imports = [
    # auto-generated (hardware layout, filesystems, swap) — regenerate with
    # `nixos-generate-config` if hardware changes
    ./hardware-configuration.nix

    # per-concern modules; each file owns one subsystem to keep diffs focused
    ./modules/nix.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/desktop.nix
    ./modules/audio.nix
    ./modules/security.nix
    ./modules/users.nix
    ./modules/virtualization.nix
    ./modules/bluetooth.nix
    ./modules/power.nix
  ];

  # Some hardware (e.g. Wi-Fi/Bluetooth drivers) is non-free; NixOS ships the
  # firmware blobs once this flag allows redistributable firmware.
  hardware.enableRedistributableFirmware = true;

  # Pin the NixOS release this config was first built against.
  # Convention: never raise this value; it guards option renames across
  # upgrades and should only move when deliberately migrating the system.
  system.stateVersion = "26.05";
}
