{...}: {
  # --- module: audio.nix ---------------------------------------------------

  # rtkit grants realtime scheduling to audio clients.
  security.rtkit.enable = true;

  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      # Provide the ALSA + PulseAudio compatibility layers.
      alsa.enable = true;
      alsa.support32Bit = true; # 32-bit apps (Wine/Steam etc.) need 32-bit ALSA
      pulse.enable = true;
    };
  };
}
