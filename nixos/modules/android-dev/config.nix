{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.android-dev;
in {
  options.programs.android-dev = {
    enable = mkEnableOption "system-level Android/Flutter development support";

    user = mkOption {
      type = types.str;
      description = "User to add to the kvm group";
    };

    enableAdb = mkEnableOption "adb (android-tools) in system packages";
    addToKvmGroup = mkEnableOption "KVM group membership for emulator hardware acceleration";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        android-studio
      ]
      ++ optional cfg.enableAdb android-tools;

    users.users.${cfg.user}.extraGroups =
      optional cfg.addToKvmGroup "kvm";
  };
}
