{...}: {
  # --- module: power.nix ---------------------------------------------------
  services = {
    fstrim.enable = true;
    fwupd.enable = true;
    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
    };

    tlp = {
      enable = true;
      settings = {
        TLP_DEFAULT_MODE = "BAT";
        TLP_PERSISTENT_DEFAULT = 1;

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "balanced";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "balanced";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };
  zramSwap.enable = true;
}
