{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.flutter;

  androidComposition = pkgs.androidenv.composeAndroidPackages {
    includeEmulator = true;
    includeSystemImages = true;
    systemImageTypes = ["google_apis_playstore"];
    abiVersions = ["x86_64"];
    includeSources = false;
    extraLicenses = [
      "android-googletv-license"
      "android-sdk-arm-dbt-license"
      "android-sdk-license"
      "android-sdk-preview-license"
      "google-gdk-license"
      "intel-android-extra-license"
      "intel-android-sysimage-license"
      "mips-android-sysimage-license"
    ];
  };

  androidSdk = androidComposition.androidsdk;
  sdkRoot = "${androidSdk}/libexec/android-sdk";
in {
  options.programs.flutter.enable =
    mkEnableOption "Flutter development environment";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      flutter
      jdk17
      gradle
      firebase-tools
      androidSdk
    ];

    home.sessionVariables = {
      ANDROID_SDK_ROOT = sdkRoot;
      ANDROID_HOME = sdkRoot;
      JAVA_HOME = "${pkgs.jdk17}";
      GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${sdkRoot}/build-tools/34.0.0/aapt2";
    };

    home.sessionPath = [
      "${sdkRoot}/platform-tools"
      "${sdkRoot}/cmdline-tools/latest/bin"
      "${sdkRoot}/emulator"
      "$HOME/.pub-cache/bin"
    ];
  };
}
