{...}: {
  # --- module: audio.nix ---------------------------------------------------
  # Owns the audio stack (PipeWire + realtime scheduling).

  # Set up sound with PipeWire, the modern audio server. We disable PulseAudio
  # explicitly because PipeWire now provides a PulseAudio-compatible layer
  # itself (alsa.pulse below) — the two would otherwise fight over the device.
  services.pulseaudio.enable = false;

  # rtkit grants realtime scheduling to audio clients (needed for glitch-free
  # low-latency audio under PipeWire/Jack).
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    # Provide the ALSA + PulseAudio compatibility layers so legacy apps
    # (mpv, browsers, etc.) keep working as if nothing changed.
    alsa.enable = true;
    alsa.support32Bit = true; # 32-bit apps (Wine/Steam etc.) need 32-bit ALSA
    pulse.enable = true;

    # If you want to use JACK applications, uncomment this.
    #jack.enable = true;
  };
}
