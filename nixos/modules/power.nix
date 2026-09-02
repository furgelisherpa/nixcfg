{pkgs, ...}: {
  # --- module: power.nix ---------------------------------------------------
  # Owns power/energy management: profiles, SSD health, firmware, swap, lid.

  # Power-profiles-daemon so the desktop exposes balanced/performance modes
  # (used by COSMIC's power settings).
  services.power-profiles-daemon.enable = true;

  # Periodic TRIM for SSD — keeps flash write performance from degrading over
  # time (fstrim weekly by default).
  services.fstrim.enable = true;

  # Firmware updates (BIOS, SSD, peripherals) via LVFS/`fwupdmgr`.
  services.fwupd.enable = true;

  # Use zram (compressed RAM) as swap instead of relying only on disk swap.
  # On a RAM-limited machine this keeps more working-set in memory and reduces
  # disk thrash under pressure.
  zramSwap.enable = true;

  # Lid-close behavior (via logind). Suspend on battery AND on external power:
  # this is a laptop, so closing the lid should always suspend regardless of
  # whether it's plugged in.
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
  };
}
